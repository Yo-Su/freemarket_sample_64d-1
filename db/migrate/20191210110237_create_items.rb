class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string  :status,              null: false #出品ステータス
      t.string  :name,                null: false #商品名
      t.string  :from_delivery_area,  null: false #配送元地域
      t.string  :to_delivery_area                 #配送先地域
      t.integer :price,               null: false #価格
      t.string  :delivery_date,       null: false #発送日の目安
      t.string  :size                             #服のサイズ
      t.string  :grade,               null: false #商品の状態
      t.string :transfer_fee,         null: false #配送料の負担
      t.string  :delivery_type,       null: false #発送の方法
      t.text    :describe,            null: false #商品の説明
      t.integer :buyer_id                         #購入者ID
      t.integer :user_id,             null: false #売却者ID
      t.integer :brand_id                         #ブランドID
      t.integer :category_id,         null: false #カテゴリーID
      t.timestamps
    end
  end
end