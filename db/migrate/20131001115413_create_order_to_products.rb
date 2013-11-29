class CreateOrderToProducts < ActiveRecord::Migration
  def change
    create_table :order_to_products do |t|
      t.integer :order_id
      t.integer :store_id
      t.integer :product_id
      t.integer :quantity
      t.decimal :price

      t.timestamps
    end
  end
end
