class ChangeDatatypeFromDeliveryAreaOfItems < ActiveRecord::Migration[5.2]
  def change
    change_column :items, :from_delivery_area, :integer
  end
end
