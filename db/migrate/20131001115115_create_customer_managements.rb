class CreateCustomerManagements < ActiveRecord::Migration
  def change
    create_table :customer_managements do |t|
      t.string :name
      t.string :password
      t.string :email
      t.integer :customer_id
      t.string :remember_token
      t.string :password_digest

      t.timestamps
    end
  end
end
