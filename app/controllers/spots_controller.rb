class SpotsController < ApplicationController
  def create
    @spot = Spot.build(spot_params)
    results = Geocoder.search(spot_params[:name])
    @latlng = results.first.coordinates
    @spot.latitude = @latlng[0]
    @spot.longitude = @latlng[1]
    @spot.address = results.first.address
    @spot.save
  end

  private

  def spot_params
    params.require(:spot).permit(:name)
  end
end