class MypagesController < ApplicationController
  def myplans
    @plans = current_user.plans.page(params[:page])
  end
end
