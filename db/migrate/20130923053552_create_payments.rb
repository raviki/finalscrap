class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :payment_method
      t.decimal :payment_amount

      t.timestamps
    end
  end
end
