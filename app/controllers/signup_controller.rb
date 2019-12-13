class SignupController < ApplicationController

  def member_info
    @user = User.new # 新規インスタンス作成
  end

  def phone_info
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

  def sms_confirmation
    
    # step2で入力された値をsessionに保存
    if params[:user]
      session[:phone_number] = user_params[:phone_number]
      @user = User.new # 新規インスタンス作成
    end
  end

  def create
    @user = User.new(
      nick_name: session[:nick_name], # sessionに保存された値をインスタンスに渡す
      email: session[:email],
      password: session[:password],
      last_name: session[:last_name], 
      first_name: session[:first_name], 
      last_name_kana: session[:last_name_kana], 
      first_name_kana: session[:first_name_kana],
      phone_number: session[:phone_number],
      birthday: "#{session[:birth_year]}-#{session[:birth_month]}-#{session[:birth_day]}"
    )
    if @user.save
    # ログインするための情報を保管
      session[:id] = @user.id
      redirect_to address_info_signup_index_path
    else
      redirect_to member_info_signup_index_path
    end
  end

  def address_info
    @address = Address.new
  end

  def credit_info
    @address = Address.new(address_params)
    unless @address.save
      render action: :address_info
    end
  end

  # def credit_info
  #   if params[:address]
  #     session[:address_last_name] = address_params[:last_name]
  #     session[:address_first_name] = address_params[:first_name]
  #     session[:address_last_name_kana] = address_params[:last_name_kana]
  #     session[:address_first_name_kana] = address_params[:first_name_kana]
  #     session[:post_number] = address_params[:post_number]
  #     session[:prefecture] = address_params[:prefecture]
  #     session[:municipality] = address_params[:municipality]
  #     session[:block] = address_params[:block]
  #     session[:building] = address_params[:building]
  #     session[:address_phone_number] = address_params[:phone_number]
  #   end
  # end

  def complete
    sign_in User.find(session[:id]) unless user_signed_in?
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
        :phone_number
      )
    end
  end

  def address_params
    params.require(:address).permit(
      :last_name,
      :first_name,
      :last_name_kana,
      :first_name_kana,
      :post_number,
      :prefecture,
      :municipality,
      :block,
      :building,
      :phone_number
    ).merge(user_id: current_user.id)
  end

end
