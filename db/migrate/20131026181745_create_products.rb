class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.text :name
      t.integer :parent
      t.string :image
      t.text :description
      t.text :meta_description
      t.text :meta_keyword
      t.integer :views
      t.boolean :active
      t.string  :video
      t.text  :how2fix
      t.string  :menu_parent
      
      t.timestamps
    end
  end
end
