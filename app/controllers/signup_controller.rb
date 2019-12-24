class SignupController < ApplicationController
  before_action :authenticate_user!, only:[:address_info, :credit_info]

  def index
  end

  def member_info
    # SNS認証のとメールアドレス登録で場合分け
    @user = if session[:password]
      User.new(
        nick_name: session[:nick_name],
        email: session[:email],
        password: session[:password]
      )
    else
      User.new
    end
  end

  def phone_info
    # step1で入力された値をsessionに保存
    if params[:user]
      session[:nick_name] = user_params[:nick_name]
      session[:email] = user_params[:email]
      session[:password] ||= user_params[:password]
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
      #ユーザ登録と同時にsns_credentialも登録する
      SnsCredential.create(
        uid: session[:uid],
        provider: session[:provider],
        user_id: @user.id
      )
      # ログインするための情報を保管
      sign_in User.find(@user.id) unless user_signed_in?
      redirect_to address_info_signup_index_path
    else
      session.delete(:password) unless session[:uid]
      redirect_to member_info_signup_index_path
    end
  end

  def address_info
    @address = Address.find_or_initialize_by(user_id: current_user.id)
  end

  def credit_info
    request_from = session[:request_from]
    session.delete(:request_from)
    @address = Address.find_or_initialize_by(user_id: current_user.id)

    render action: :address_info unless @address.update(address_params)
    redirect_to request_from ? request_from : new_card_path
  end

  def complete
  end

  private
  # 許可するキーを設定します
  def user_params
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
