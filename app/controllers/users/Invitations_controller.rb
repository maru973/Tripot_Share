class Users::InvitationsController < Devise::InvitationsController
  def create
      super
      @member = Member.new
      #Memberテーブルに招待したいユーザーのidを入れる。
      @member.user_id = User.find_by(email: params[:user][:email]).id
      @member.plan_id = params[:user][:plan_id]
      @member.save
  end

  # def create
  #   user_email = params[:user][:email]
  #   plan_id = params[:user][:plan_id]
  #   user_id = User.find_by(email: user_email.downcase).id
  #   if User.find_by(email: user_email.downcase).present? #　既存ユーザーの処理
  #     user = User.find(user_id)
  #     if user.plan_ids.include?(plan_id.to_i)
  #       redirect_to root_path, alert: "このリストは登録済みです。"
  #     else
  #     user.invite!
  #     @member = Member.new
  #     #Memberテーブルに招待したいユーザーのidとリストのidを入れる。
  #     @member.user_id = user_id
  #     @member.plan_id = plan_id
  #     @member.save
  #     redirect_to root_path, notice: t('.send_instructions')
  #     end
  #   elsif User.invite!(email: user_email, plan_id: plan_id) # 新規ユーザーの処理
  #     redirect_to plans_path(current_user), notice: t('.send_instructions')
  #     @member = Member.new
  #     @member.user_id = user_id
  #     @member.plan_id = plan_id
  #     @member.save
  #   else
  #     flash[:notice] = t('.failure')
  #     render 'new', locals: { plan: plan_id }
  #   end
  # end
end