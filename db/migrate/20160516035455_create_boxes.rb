class CreateBoxes < ActiveRecord::Migration
  def change
    create_table :boxes do |t|
      t.float :length
      t.float :width
      t.float :height
      t.float :weight

      t.timestamps null: false
    end
  end
end
