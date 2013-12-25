class AddIncludeServiceToCartItems < ActiveRecord::Migration
  def change
    add_column :cart_items, :include_service, :boolean
  end
end
