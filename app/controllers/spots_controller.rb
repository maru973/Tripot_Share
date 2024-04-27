class SpotsController < ApplicationController
  def create
    results = Geocoder.search(params[:name])
    @latlng = results.first.coordinates
  end
end