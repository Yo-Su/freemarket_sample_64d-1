class ChangeDatatypeStatusOfItems < ActiveRecord::Migration[5.2]
  def change
    change_column :items, :status, :integer
  end
end
