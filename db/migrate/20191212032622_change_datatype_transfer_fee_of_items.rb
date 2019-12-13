class ChangeDatatypeTransferFeeOfItems < ActiveRecord::Migration[5.2]
  def change
    change_column :items, :transfer_fee, :integer
  end
end
