class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[google_oauth2] # Google認証用に追加
  attr_accessor :birth_year, :birth_month, :birth_day

  has_many :addresses, dependent: :destroy
  has_many :credit_card_infos, dependent: :destroy
  has_many :sns_credentials, dependent: :destroy

  # ユーザー登録用
  before_save { self.email = email.downcase }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, {presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }}

  validates :password,
    presence: true,
    length: { minimum: 7 },
    format: { with: /\A[a-z0-9]+\z/i }

  with_options presence: true, format: {with: /\A[^ -~｡-ﾟ]+\z/, message: "全角のみで入力して下さい"} do
    validates :last_name
    validates :first_name
  end

  with_options presence: true, format: {with: /\A[\p{katakana} ー－&&[^ -~｡-ﾟ]]+\z/, message: "全角カタカナのみで入力して下さい"} do
    validates :last_name_kana
    validates :first_name_kana
  end

  with_options presence: true do
    validates :nick_name
    validates :birthday
    validates :phone_number
  end

  #===Google認証、Facebook認証================================================================================
  #omniauth_callbacks_controllerで呼び出すメソッド
  def self.find_oauth(auth)
    uid = auth.uid
    provider = auth.provider
    snscredential = SnsCredential.where(uid: uid, provider: provider).first

    #sns_credentialsが登録されている場合
    if snscredential.present?
      user = User.where(email: auth.info.email).first

      # userが登録されていない場合
      unless user.present?
        user = User.new(
        nick_name: auth.info.name,
        email: auth.info.email
        )
      end
      sns = snscredential
      { user: user, sns: sns}

    #sns_credentialsが登録されていない場合
    else
      user = User.where(email: auth.info.email).first

      # userが登録されている場合
      if user.present?
        sns = SnsCredential.create(
          uid: uid,
          provider: provider,
          user_id: user.id
        )

        { user: user, sns: sns}

      # userが登録されていない場合
      else
        user = User.new(
        nick_name: auth.info.name,
        email: auth.info.email,
        )
        sns = SnsCredential.new(
          uid: uid,
          provider: provider
        )

        { user: user, sns: sns}
      end
    end
  end

end
