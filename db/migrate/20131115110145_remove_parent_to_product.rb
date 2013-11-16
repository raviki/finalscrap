class RemoveParentToProduct < ActiveRecord::Migration
  def change
    remove_column :products, :parent, :integer
  end
end
