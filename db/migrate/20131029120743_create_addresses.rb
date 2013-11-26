class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :name
      t.text :address
      t.string :city
      t.integer :pin
      t.string :phone
      t.string :email
      t.integer :user_id

      t.timestamps
    end
  end
end
