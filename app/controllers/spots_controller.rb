class SpotsController < ApplicationController
  def create
    @spot = Spot.find_or_initialize_by(name: spot_params[:name])
    if @spot.new_record?
      results = Geocoder.search(spot_params[:name])
      @latlng = results.first.coordinates
      @spot.latitude = @latlng[0]
      @spot.longitude = @latlng[1]
      @spot.address = results.first.address
      @spot.save
    end
    @planned_spot = PlannedSpot.find_or_initialize_by(plan_id: params[:plan_id], spot_id: @spot.id)
    if @planned_spot.new_record?
      @planned_spot.save
    end
  end

  private

  def spot_params
    params.require(:spot).permit(:name)
  end
end