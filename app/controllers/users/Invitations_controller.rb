class Users::InvitationsController < Devise::InvitationsController
  def create
    @user =User.new
    user_email = params[:user][:email]
    plan_id = params[:user][:plan_id]
    if User.find_by(email: user_email.downcase).present? #　既存ユーザーの処理
      user_id = User.find_by(email: user_email.downcase).id
      user = User.find(user_id)
      if user.plan_ids.include?(plan_id.to_i)
        redirect_to root_path, alert: "このリストは登録済みです。"
      else
        user.invite!(current_user)
        #Memberテーブルに招待したいユーザーのidとリストのidを入れる。
        user.invited_plan_id = plan_id
        user.save
        redirect_to root_path, notice: t('devise.invitations.send_instructions', email: user_email)
      end
    elsif User.invite!(email: user_email, invited_plan_id: plan_id).valid? # 新規ユーザーの処理
      redirect_to plans_path(current_user), notice: t('devise.invitations.send_instructions', email: user_email)
    else
      flash[:notice] = t('devise.invitations.failure')
      render 'new', locals: { plan: plan_id }
    end
  end

  def update
    raw_invitation_token = update_resource_params[:invitation_token]
    self.resource = accept_resource
    invitation_accepted = resource.errors.empty?

    user_id = resource.id
    user = User.find(user_id)
    Member.create(user_id: user_id, plan_id: user.invited_plan_id)
    yield resource if block_given?

    if invitation_accepted
      if resource.class.allow_insecure_sign_in_after_accept
        flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
        set_flash_message :notice, flash_message if is_flashing_format?
        resource.after_database_authentication
        sign_in(resource_name, resource)
        respond_with resource, location: plans_path
      else
        set_flash_message :notice, :updated_not_active if is_flashing_format?
        respond_with resource, location: new_session_path(resource_name)
      end
    else
      resource.invitation_token = raw_invitation_token
      respond_with_navigational(resource) { render :edit, status: :unprocessable_entity }
    end
  end
end