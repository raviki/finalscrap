class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.string :name
      t.text :contact_name
      t.decimal :contact_no
      t.text :address
      t.decimal :pin
      t.text :review
      t.decimal :rating
      t.boolean :active

      t.timestamps
    end
  end
end
