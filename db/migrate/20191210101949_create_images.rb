class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :images do |t|
      t.string  :url,     null: false #商品画像URL
      t.integer :item_id, null: false #商品ID
      t.timestamps
    end
  end
end
