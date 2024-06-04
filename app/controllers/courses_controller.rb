class CoursesController < ApplicationController
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

  private

  def course_params
    params.require(:course).permit(:start_location, :end_location)
  end
end
