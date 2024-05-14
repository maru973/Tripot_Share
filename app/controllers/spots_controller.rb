class SpotsController < ApplicationController
  def create
    @user = current_user
    @spot = Spot.find_or_initialize_by(name: spot_params[:name])
    if @spot.new_record?
      results = Geocoder.search(spot_params[:name])
      @latlng = results.first.coordinates
      @spot.latitude = @latlng[0]
      @spot.longitude = @latlng[1]
      @spot.address = results.first.address
      
      spot_details = @spot.get_spot_details(spot_params[:name])
      if spot_details
        @spot.opening_hours = spot_details[:opening_hours].split(",").join("\n") if spot_details[:opening_hours].present?
        @spot.website = spot_details[:website]
        @spot.phone_number = spot_details[:phone_number]
      end

      @spot.save
    end
    @planned_spot = PlannedSpot.find_or_initialize_by(plan_id: params[:plan_id], spot_id: @spot.id)
    if @planned_spot.new_record?
      @planned_spot.user_id = current_user.id
      @planned_spot.save
    end
  end

  def destroy
    @plan = Plan.find(params[:plan_id])
    @spot = Spot.find(params[:id])
    @planned_spot = @plan.planned_spots.find_by(spot_id: @spot.id)
    @planned_spot.destroy!
  end

  private

  def spot_params
    params.require(:spot).permit(:name)
  end
end