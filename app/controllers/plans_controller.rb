class PlansController < ApplicationController
  def new
    @plan = Plan.new
  end

  def create
    @plan = Plan.build(plan_params)
    if @plan.save
      redirect_to plans_new2_path(@plan)
    else
      render :new
    end
  end

  def new2
    @plan = Plan.find(params[:id])
    @spot = Spot.new
    @spots = @plan.spots
  end

  private

  def plan_params
    params.require(:plan).permit(:name, :start_date, :end_date)
  end
end
