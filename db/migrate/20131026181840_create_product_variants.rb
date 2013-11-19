class CreateProductVariants < ActiveRecord::Migration
  def change
    create_table :product_variants do |t|
      t.integer :product_id
      t.text :value

      t.timestamps
    end
  end
end
