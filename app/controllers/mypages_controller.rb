class MypagesController < ApplicationController
  before_action :check_guest, only: :update
  def show; end

  def edit
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(current_user.id)
    if @user.update(user_params)
      redirect_to mypage_path, notice: "プロフィールを更新しました"
    else
      redirect_to mypage_path, alert: "エラーが発生しました"
    end
  end

  def myplans
    @q = current_user.plans.ransack(params[:q])
    @plans = @q.result(distinct: true).includes(:users).order(created_at: :desc).page(params[:page])
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :avatar, :avatar_cache)
  end
end
