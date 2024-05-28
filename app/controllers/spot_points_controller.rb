class SpotPointsController < ApplicationController
  def new
    @plan = Plan.find(params[:id])
    @location = Spot.find_by(name: @plan.location)
    @users = @plan.users
    @spots = @plan.spots # マーカーを表示に使用
    @user_spots = {}
    @spot_subscribers = {}
    
    @spot_point = SpotPoint.new

    @spots.each do |spot|
      @spot_subscribers[spot.id] = User.joins(:planned_spots).where(planned_spots: { plan_id: @plan.id, spot_id: spot.id })
    end
    
    @users.each do |user|
      @user_spots[user.id] = Spot.joins(:planned_spots).where(planned_spots: { plan_id: @plan.id, user_id: user.id })
    end
    @user = User.new
    @resource_name = @user.class.name.underscore
    @invite_link = accept_plan_url(invitation_token: @plan.invitation_token) if @plan.invitation_token.present?
  end

  def create

  end
  
end
