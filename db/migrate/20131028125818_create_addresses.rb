class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.text :address
      t.string :city
      t.integer :pin
      t.integer :phone
      t.string :email

      t.timestamps
    end
  end
end
