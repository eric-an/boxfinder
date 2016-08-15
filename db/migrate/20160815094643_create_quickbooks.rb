class CreateQuickbooks < ActiveRecord::Migration
  def change
    create_table :quickbooks do |t|
      t.string :sku
      t.string :name

      t.timestamps null: false
    end
  end
end
