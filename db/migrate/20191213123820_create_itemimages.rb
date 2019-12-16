class CreateItemimages < ActiveRecord::Migration[5.2]
  def change
    create_table :itemimages do |t|
      t.string  :image,     null: false #商品画像URL
      t.integer :item_id, null: false   #商品ID
      t.timestamps
    end
  end
end
