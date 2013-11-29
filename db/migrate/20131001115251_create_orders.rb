class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :customer_id
      t.integer :voucher_id
      t.integer :payment_id
      t.integer :address_id
      t.decimal :discount
      t.text :discount_message
      t.time :appointment_date
      t.decimal :duration_inHrs
      t.boolean :active

      t.timestamps
    end
  end
end
