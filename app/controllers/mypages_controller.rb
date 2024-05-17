class MypagesController < ApplicationController
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
    @plans = current_user.plans.order(created_at: :desc).page(params[:page])
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :avatar, :avatar_cache)
  end
end
