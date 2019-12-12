class CreateCreditCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
      t.integer :card_number, null: false # クレジットカード番号
      t.string  :brand,       null: false # カード種類
      t.integer :exp_month,   null: false # 有効期限：年
      t.integer :exp_year,    null: false # 有効期限：月
      t.integer :user_id,     null: false # カード所有者
      t.timestamps
    end
  end
end
