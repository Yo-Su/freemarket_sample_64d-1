class ChangeDatatypeDeliveryTypeOfItems < ActiveRecord::Migration[5.2]
  def change
    change_column :items, :delivery_type, :integer
  end
end
