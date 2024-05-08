class PlansController < ApplicationController
  def index
    @plans = current_user.plans.page(params[:page])
  end

  def new
    @plan = Plan.new
  end

  def create
    @plan = current_user.plans.build(plan_params)
    @plan.owner_id = current_user.id
    if @plan.save
      redirect_to new_spots_path(@plan), notice: "プランを作成しました"
    else
      flash.now[:alert] = "プランの作成に失敗しました"
      render :new, status: :unprocessable_entity
    end
  end

  def new_spots
    @plan = Plan.find(params[:id])
    @spot = Spot.new
    @spots = @plan.spots
  end

  def show
    @plan = Plan.find(params[:id])
    @spots = @plan.spots
  end

  private

  def plan_params
    params.require(:plan).permit(:name, :start_date, :end_date)
  end
end
