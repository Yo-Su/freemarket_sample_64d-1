class Address < ApplicationRecord

  belongs_to :user
  with_options presence: true, format: {with: /\A[^ -~｡-ﾟ]+\z/, message: "全角のみで入力して下さい"} do
    validates :last_name
    validates :first_name
  end

  with_options presence: true, format: {with: /\A[\p{katakana} ー－&&[^ -~｡-ﾟ]]+\z/, message: "全角カタカナのみで入力して下さい"} do
    validates :last_name_kana
    validates :first_name_kana
  end

  with_options presence: true do
    validates :post_number
    validates :prefecture
    validates :municipality
    validates :block
  end

end
