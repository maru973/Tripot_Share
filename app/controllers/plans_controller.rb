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
      @plan.users << current_user
      redirect_to new_spots_path(@plan), notice: t('defaults.flash_message.created', item: Plan.model_name.human)
    else
      flash.now[:alert] = t('defaults.flash_message.not_created', item: Plan.model_name.human)
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
    @user =User.new
    @resource_name = @user.name
  end

  private

  def plan_params
    params.require(:plan).permit(:name, :start_date, :end_date)
  end
end
