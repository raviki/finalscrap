class AddTypeToProduct < ActiveRecord::Migration
  def change
    add_column :products, :price, :string
  end
end
