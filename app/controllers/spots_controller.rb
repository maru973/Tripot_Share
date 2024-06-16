class SpotsController < ApplicationController
  def create
    @user = current_user

    respond_to do |format|
      case
      when spot_params.blank? 
        format.turbo_stream do
          flash.now[:alert] = 'スポット名を入力してください'
          render turbo_stream: turbo_stream.prepend("flash", partial: "shared/flash_message")
        end
      when (@spot = Spot.save_spot(spot_params[:name])) == false
        format.turbo_stream do
          flash.now[:alert] = 'スポットが見つかりませんでした'
          render turbo_stream: turbo_stream.prepend("flash", partial: "shared/flash_message")
        end
      when @spot.present?
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