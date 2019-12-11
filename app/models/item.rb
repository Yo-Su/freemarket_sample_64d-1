class Item < ApplicationRecord
  has_many    :images    ,dependent: :destroy
  has_many    :messages  ,dependent: :destroy
  has_many    :likes     ,dependent: :destroy
  belongs_to  :user
  belongs_to  :brand
  belongs_to  :category
end
