class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def google_oauth2
    callback_for(:google)
  end

  def facebook
    callback_for(:facebook)
  end

  # callbackメソッド(google, facebook)
  def callback_for(provider)
    info = User.find_oauth(request.env["omniauth.auth"])
    @user = User.where(email: info[:user][:email]).first || info[:user]
    # DBに保存されている場合はログインしてトップページへ
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
    # 保存されていなければsessionに情報渡す
    else
      session[:nick_name] = info[:user][:nick_name]
      session[:email] = info[:user][:email]
      session[:password] = SecureRandom.alphanumeric(30)

      #SnsCredentialが登録されていない場合
      if SnsCredential.find_by(uid: info[:sns][:uid], provider: info[:sns][:provider]).nil?
        session[:uid] = info[:sns][:uid]
        session[:provider] = info[:sns][:provider]
      end
      #登録フォームのviewにリダイレクトさせる
      redirect_to member_info_signup_index_path
    end
  end

  def failure
    redirect_to root_path
  end
end
