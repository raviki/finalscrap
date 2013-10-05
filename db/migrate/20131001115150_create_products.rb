class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.text :name
      t.string :image
      t.decimal :price
      t.text :description
      t.text :meta_description
      t.text :meta_keyword
      t.integer :views
      t.boolean :active

      t.timestamps
    end
  end
end
