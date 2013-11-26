class CreateCartItems < ActiveRecord::Migration
  def change
    create_table :cart_items do |t|
      t.integer :product_id
      t.decimal :price
      t.integer :quantity
      t.string  :units
      
      t.timestamps
    end
  end
end
