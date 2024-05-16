class MypagesController < ApplicationController
  def myplans
    @plans = current_user.plans.order(created_at: :desc).page(params[:page])
  end
end
