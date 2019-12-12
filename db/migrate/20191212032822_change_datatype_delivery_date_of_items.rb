class ChangeDatatypeDeliveryDateOfItems < ActiveRecord::Migration[5.2]
  def change
    change_column :items, :delivery_date, :integer
  end
end
