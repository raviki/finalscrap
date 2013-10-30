class AddPriceToOrderToProduct < ActiveRecord::Migration
  def change
    add_column :order_to_products, :price, :decimal
  end
end
