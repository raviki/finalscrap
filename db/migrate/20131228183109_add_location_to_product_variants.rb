class AddLocationToProductVariants < ActiveRecord::Migration
  def change
    add_column :product_variants, :location, :string
  end
end
