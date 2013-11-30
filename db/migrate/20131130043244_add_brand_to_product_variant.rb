class AddBrandToProductVariant < ActiveRecord::Migration
  def change
    add_column :product_variants, :brand, :string
  end
end
