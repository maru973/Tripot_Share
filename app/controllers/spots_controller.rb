class SpotsController < ApplicationController
  def create
    @user = current_user

    respond_to do |format|
      if spot_params[:name].blank?
        format.turbo_stream do
          flash.now[:alert] = 'スポット名を入力してください'
          render turbo_stream: turbo_stream.prepend("flash", partial: "shared/flash_message")
        end
      else
        @spot = Spot.find_or_initialize_by(name: spot_params[:name])
        if @spot.new_record?
          results = Geocoder.search(spot_params[:name])
          @latlng = results.first.coordinates
          @spot.latitude = @latlng[0]
          @spot.longitude = @latlng[1]
          @spot.address = results.first.address

          spot_details = @spot.get_spot_details(spot_params[:name])
          if spot_details
            @spot.place_id = spot_details[:place_id]
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
          format.turbo_stream { flash.now[:notice] = "スポットを登録しました" }
        end
        format.turbo_stream { flash.now[:alert] = "そのスポットはすでにプランに登録されています" }
      end
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