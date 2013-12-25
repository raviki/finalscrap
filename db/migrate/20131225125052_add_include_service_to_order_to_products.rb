class AddIncludeServiceToOrderToProducts < ActiveRecord::Migration
  def change
    add_column :order_to_products, :include_service, :boolean
  end
end
