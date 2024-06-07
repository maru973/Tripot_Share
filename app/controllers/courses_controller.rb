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
    
    if @course.start_location.present? && @course.end_location.present?
      if @start_location.new_record?
        results = Geocoder.search(@course.start_location)
        @latlng = results.first.coordinates
        @start_location.latitude = @latlng[0]
        @start_location.longitude = @latlng[1]
        @start_location.address = results.first.address

        spot_details = @start_location.get_spot_details(@course.start_location)
        if spot_details
          @start_location.place_id = spot_details[:place_id]
          @start_location.opening_hours = spot_details[:opening_hours].split(",").join("\n") if spot_details[:opening_hours].present?
          @start_location.website = spot_details[:website]
          @start_location.phone_number = spot_details[:phone_number]
        end

        @start_location.save
      end
      if @course.end_location.present? && @end_location.new_record?
        results = Geocoder.search(@course.end_location)
        @latlng = results.first.coordinates
        @end_location.latitude = @latlng[0]
        @end_location.longitude = @latlng[1]
        @end_location.address = results.first.address

        spot_details = @end_location.get_spot_details(@course.end_location)
        if spot_details
          @end_location.place_id = spot_details[:place_id]
          @end_location.opening_hours = spot_details[:opening_hours].split(",").join("\n") if spot_details[:opening_hours].present?
          @end_location.website = spot_details[:website]
          @end_location.phone_number = spot_details[:phone_number]
        end

        @end_location.save
      end
      @course.save
      redirect_to course_path(@course), notice: 'コースを作成しました'
    end
  end

  def show
    @course = Course.find(params[:id])
    @start_location = Spot.find_by(name: @course.start_location)
    @end_location = Spot.find_by(name: @course.end_location)

    @spot_subscribers = {}

    spot_ids = @spot_points.keys
    spots = Spot.where(id: spot_ids)
    @ranking_spots = Spot.joins(:planned_spots)
      .where(id: spot_ids, planned_spots: { plan_id: @plan.id })
      .order('planned_spots.row_order')

    @ranking_spots.each do |spot|
      @spot_subscribers[spot.id] = User.joins(:planned_spots).where(planned_spots: { plan_id: @plan.id, spot_id: spot.id })
    end
  end

  def update_position
    @plan = Course.find(params[:id]).plan
    # JSのルート検索で出てきた結果のplace_idを取得
    place_ids = params[:place_ids]

    # 配列の最初(出発地のplace_id)と最後(到着地のplace_id)を削除
    place_ids.shift
    place_ids.pop
    
    place_ids.each_with_index do |place_id, index|
      spot = Spot.find_by(place_id: place_id)
      if spot
        planned_spot = PlannedSpot.find_by(spot_id: spot.id, plan_id: @plan.id)
        planned_spot.update(row_order: index + 1) # 1から始めるためにindexに1を足す
      end
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
