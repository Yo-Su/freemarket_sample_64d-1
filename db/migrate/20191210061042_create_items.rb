class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string  :status,null: false
      t.string  :name,null: false
      t.string  :from_delivery_area,null: false
      t.string  :to_delivery_area,null: false
      t.integer  :price,null: false
      t.date  :delivery_date,null: false
      t.string  :size,null: false
      t.string  :grade,null: false
      t.integer  :transfer_fee,null: false
      t.string  :delivery_type,null: false
      t.string  :describe,null: false
      t.integer  :buyer_id,null: false
      t.timestamps
    end
  end
end

