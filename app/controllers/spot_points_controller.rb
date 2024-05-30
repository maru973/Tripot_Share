class SpotPointsController < ApplicationController
  before_action :set_plan_and_spot, only: [:edit]
  before_action :set_spot_point, only: [:edit]

  def index
    @plan = Plan.find(params[:plan_id])
    @location = Spot.find_by(name: @plan.location)
    @users = @plan.users
    @spots = @plan.spots
    @user_spots = {}
    @spot_subscribers = {}
    @spot_points = {}

    @spots.each do |spot|
      @spot_subscribers[spot.id] = User.joins(:planned_spots).where(planned_spots: { plan_id: @plan.id, spot_id: spot.id })
      @planned_spot = PlannedSpot.find_by(plan_id: @plan.id, spot_id: spot.id)
      @spot_points[spot.id] = SpotPoint.find_or_create_by(user_id: current_user.id, planned_spot_id: @planned_spot.id)
    end
    
    @users.each do |user|
      @user_spots[user.id] = Spot.joins(:planned_spots).where(planned_spots: { plan_id: @plan.id, user_id: user.id })
    end
    @user = User.new
    @resource_name = @user.class.name.underscore
    @invite_link = accept_plan_url(invitation_token: @plan.invitation_token) if @plan.invitation_token.present?
  end

  def edit
    @spot_point = current_user.spot_points.find_by(planned_spot_id: @planned_spot.id)
  end

  def update
    @spot_point = current_user.spot_points.find(params[:id])
    @spot = @spot_point.planned_spot.spot
    @plan = @spot_point.planned_spot.plan
    @user = @spot_point.planned_spot.user
    @spot_point.update(spot_point_params)
  end

  private

  def set_plan_and_spot
    @plan = Plan.find(params[:plan_id])
    @spot = Spot.find(params[:id])
  end

  def set_spot_point
    @planned_spot = PlannedSpot.find_by(plan_id: @plan.id, spot_id: @spot.id)
    @spot_point = SpotPoint.find_or_create_by(user_id: current_user.id, planned_spot_id: @planned_spot.id)
  end

  def spot_point_params
    params.require(:spot_point).permit(:point)
  end
end
