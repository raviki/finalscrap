class AddQuantityToOrderToProducts < ActiveRecord::Migration
  def change
    add_column :order_to_products, :quantity, :integer
  end
end
