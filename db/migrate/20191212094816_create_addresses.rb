class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.integer :post_number
      t.string :prefecture
      t.string :municipality
      t.string :block
      t.string :building
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
