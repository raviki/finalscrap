class RemoveQuantityToProduct < ActiveRecord::Migration
  def change
    remove_column :products, :quantity, :integer
  end
end
