class PlansController < ApplicationController
  def new
    @spot = Spot.new
  end
end
