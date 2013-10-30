class CreateCustomerManagements < ActiveRecord::Migration
  def change
    create_table :customer_managements do |t|
      t.string :name
      t.string :password
      t.string :email
      t.string :mobile_number
      t.integer :customer_id
      t.string :remember_token
      t.string :password_digest
      t.text :provider
      t.text :uid
      t.text :oauth_token
      t.datetime :oauth_expires_at
      t.string :password_reset_token
      t.datetime :password_reset_sent_at

      t.timestamps
    end
  end
end
