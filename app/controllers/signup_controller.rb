class SignupController < ApplicationController

  def step1
    @user = User.new # 新規インスタンス作成
  end

  def step2
    # step1で入力された値をsessionに保存
    if params[:user]
      session[:nick_name] = user_params[:nick_name]
      session[:email] = user_params[:email]
      session[:password] = user_params[:password]
      session[:last_name] = user_params[:last_name]
      session[:first_name] = user_params[:first_name]
      session[:last_name_kana] = user_params[:last_name_kana]
      session[:first_name_kana] = user_params[:first_name_kana]
      session[:birth_year] = user_params[:birth_year]
      session[:birth_month] = user_params[:birth_month]
      session[:birth_day] = user_params[:birth_day]
      @user = User.new # 新規インスタンス作成
    end
  end

  def step3
    
    # step2で入力された値をsessionに保存
    if params[:user]
      session[:phone_number] = user_params[:phone_number]
      @user = User.new # 新規インスタンス作成
    end
  end

  private
  # 許可するキーを設定します
  def user_params
    if params[:user]
      params.require(:user).permit(
        :nick_name,
        :email,
        :password,
        :last_name,
        :first_name,
        :last_name_kana,
        :first_name_kana,
        :birth_year,
        :birth_month,
        :birth_day,
        :birthday,
        :phone_number
      )
    end
  end

end
