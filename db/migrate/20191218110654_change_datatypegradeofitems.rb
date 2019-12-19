class ChangeDatatypegradeofitems < ActiveRecord::Migration[5.2]
  def change
    change_column :items, :grade, :integer
  end
end
