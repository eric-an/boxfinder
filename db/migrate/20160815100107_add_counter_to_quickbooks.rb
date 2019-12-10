class AddCounterToQuickbooks < ActiveRecord::Migration
  def change
    add_column :quickbooks, :counter, :integer
  end
end
