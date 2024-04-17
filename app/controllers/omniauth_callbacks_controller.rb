class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def line
    basic_action 
  end

  private

  def basic_action
    @omniauth = request.env["omniauth.auth"]
    if @omniauth.present?
      
      #このメソッドは新規作成するけど、保存はしない。find_or_create_byとの違いは、作成する時に呼ぶメソッドがcreateではなくnew。
      #ここで保存してしまうとemailが入ってないのでエラーが出る。
      @profile = User.find_or_initialize_by(provider: @omniauth["provider"], uid: @omniauth["uid"])
      
      #仮のemaiとpasswordを作成してテーブルに保存
      if @profile.email.blank?
        email = @omniauth["info"]["email"] ? @omniauth["info"]["email"] : fake_email(@omniauth["uid"], @omniauth["provider"])
        #passwordはdeviseのメソッドを使ってランダムで作成
        @profile = current_user || User.create!(provider: @omniauth["provider"], uid: @omniauth["uid"], email: email, name: @omniauth["info"]["name"], password: Devise.friendly_token[0, 20])
      end
      @profile.set_values(@omniauth) #Userモデルにset_valuesメソッドは定義
      sign_in(:user, @profile)
  
      flash[:notice] = "ログインしました"
      redirect_to root_path

    else
      flash[:alert] = '認証に失敗しました'
      new_user_session_path
    end
  end
  
  #仮のemailを作成
  def fake_email(uid, provider)
    "#{uid}-#{provider}@example.com"
  end
end
