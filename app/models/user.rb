class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  attr_accessor :birth_year, :birth_month, :birth_day

  has_many :addresses, dependent: :destroy
  has_many :credit_card_infos, dependent: :destroy

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
end
