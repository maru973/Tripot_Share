class CoursesController < ApplicationController
  def new
    @plan = Plan.find(params[:plan_id])
    @course = Course.new
  end

  def create
    @plan = Plan.find(params[:plan_id])
    @course = @plan.courses.build(course_params)
    @location = Spot.find_or_initialize_by(name: @plan.location)
      if @location.new_record?
        results = Geocoder.search(@plan.location)
        @latlng = results.first.coordinates
        @location.latitude = @latlng[0]
        @location.longitude = @latlng[1]
        @location.address = results.first.address
        @location.save
      end
  end

  private

  def course_params
    params.require(:course).permit(:start_location, :end_location)
  end
end
