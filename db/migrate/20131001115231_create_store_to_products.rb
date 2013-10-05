class CreateStoreToProducts < ActiveRecord::Migration
  def change
    create_table :store_to_products do |t|
      t.integer :store_id
      t.integer :product_id
      t.decimal :price

      t.timestamps
    end
  end
end
