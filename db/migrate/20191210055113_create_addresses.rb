class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :last_name,          null: false
      t.string :first_name,         null: false
      t.string :last_name_kana,     null: false
      t.string :first_name_kana,    null: false
      t.integer :post_number,       null: false
      t.string :prefecture,         null: false
      t.string :municipality,       null: false
      t.string :block,              null: false
      t.string :building
      t.integer :phone_number
      t.timestamps
    end
  end
end
