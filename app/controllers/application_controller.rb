class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    # 新規登録時(sign_up時)にnameというキーのパラメーターの追加を許可
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :plan_id, :avatar, :avatar_cache])
    devise_parameter_sanitizer.permit(:invite) { |u| u.permit(:email, :name, :plan_id) }
    devise_parameter_sanitizer.permit(:accept_invitation) { |u| u.permit(:password, :password_confirmation, :invitation_token, :name, :plan_id, :email) }
  end
end
