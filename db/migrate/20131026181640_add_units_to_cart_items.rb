class AddUnitsToCartItems < ActiveRecord::Migration
  def change
    add_column :cart_items, :units, :string
  end
end
