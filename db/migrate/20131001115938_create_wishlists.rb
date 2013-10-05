class CreateWishlists < ActiveRecord::Migration
  def change
    create_table :wishlists do |t|
      t.integer :customer_id
      t.integer :store_id
      t.integer :product_id

      t.timestamps
    end
  end
end
