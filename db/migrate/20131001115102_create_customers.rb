class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :first_name
      t.string :second_name
      t.decimal :contact_no
      t.text :add_line1
      t.text :add_line2
      t.text :city
      t.decimal :pin
      t.boolean :wishlist
      t.integer :customer_group_id
      t.integer :customer_lead_id

      t.timestamps
    end
  end
end
