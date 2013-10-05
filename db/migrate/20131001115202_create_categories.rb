class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.text :name
      t.string :image
      t.text :description
      t.boolean :active

      t.timestamps
    end
  end
end
