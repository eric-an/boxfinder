class AddLocationToBoxes < ActiveRecord::Migration
  def change
    add_column :boxes, :location, :string
  end
end
