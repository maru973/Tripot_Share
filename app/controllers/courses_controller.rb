class CoursesController < ApplicationController
  before_action :point_calculate, only: [:show]

  def new
    @plan = Plan.find(params[:plan_id])
    @course = Course.new
  end

  def create
    @plan = Plan.find(params[:plan_id])
    @course = @plan.courses.build(course_params)
    @start_location = Spot.find_or_initialize_by(name: @course.start_location)
    @end_location = Spot.find_or_initialize_by(name: @course.end_location)
    if @start_location.new_record?
      results = Geocoder.search(@course.start_location)
      @latlng = results.first.coordinates
      @start_location.latitude = @latlng[0]
      @start_location.longitude = @latlng[1]
      @start_location.address = results.first.address
      @start_location.save
    end
    if @end_location.new_record?
      results = Geocoder.search(@course.end_location)
      @latlng = results.first.coordinates
      @end_location.latitude = @latlng[0]
      @end_location.longitude = @latlng[1]
      @end_location.address = results.first.address
      @end_location.save
    end
    @course.save
    redirect_to course_path(@course), notice: 'コースを作成しました'
  end

  def show
    @course = Course.find(params[:id])
    @start_location = Spot.find_by(name: @course.start_location)
    @end_location = Spot.find_by(name: @course.end_location)

    @spot_subscribers = {}

    spot_ids = @spot_points.keys
    spots = Spot.where(id: spot_ids)
    @ranking_spots = spot_ids.map { |id| spots.find { |spot| spot.id == id } }

    @ranking_spots.each do |spot|
      @spot_subscribers[spot.id] = User.joins(:planned_spots).where(planned_spots: { plan_id: @plan.id, spot_id: spot.id })
    end
  end

  private

  def course_params
    params.require(:course).permit(:start_location, :end_location)
  end

  def point_calculate
    @plan = Course.find(params[:id]).plan

    @spot_points = SpotPoint.joins(:planned_spot)
      .where(planned_spots: { plan_id: @plan.id })
      .group('planned_spots.spot_id')
      .order('SUM(point) DESC')
      .limit(6)
      .sum(:point)
  end
end
