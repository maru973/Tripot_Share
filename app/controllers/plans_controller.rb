class PlansController < ApplicationController
  def new; end

  def spot
    results = Geocoder.search(params[:name])
    @latlng =results.first.coordinates
  end
end
