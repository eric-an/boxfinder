class AddHeightCheckToShipments < ActiveRecord::Migration
  def change
    add_column :shipments, :height_check, :boolean, :default => false
  end
end
