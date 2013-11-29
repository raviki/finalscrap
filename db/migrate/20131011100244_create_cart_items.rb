class CreateCartItems < ActiveRecord::Migration
  def change
    create_table :cart_items do |t|
      t.integer :product_id
      t.decimal :price
      t.integer :quantity
      t.string  :units
      t.integer :cart_id
      
      t.timestamps
    end
  end
end
