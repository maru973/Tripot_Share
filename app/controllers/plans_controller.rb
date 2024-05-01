class PlansController < ApplicationController
  def new
    @plan = Plan.new
  end
  
  def new2
    @spot = Spot.new
  end
end
