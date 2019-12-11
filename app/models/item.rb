class Item < ApplicationRecord
  has_many    :images    ,dependent: :destroy
  has_many    :messages  ,dependent: :destroy
  has_many    :likes     ,dependent: :destroy
  belongs_to  :user
  belongs_to  :brand
  belongs_to  :category

  accepts_nested_attributes_for :images, allow_destroy: true
  validates :name, presence: true
  validates :describe, presence: true
  validates :category, presence: true
  validates :price, presence: true
  validates :status, presence: true
  validates :from_delivery_area, presence: true
  validates :delivery_type, presence: true
  validates :transfer_fee, presence: true
  validates :delivery_date, presence: true

  

end
