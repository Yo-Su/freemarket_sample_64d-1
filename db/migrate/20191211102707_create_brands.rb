class CreateBrands < ActiveRecord::Migration[5.2]
  def change
    create_table :brands do |t|
      t.string  :name,    null: false #ブランド名
      t.integer :item_id, null: false #商品ID
      t.timestamps
    end
  end
end