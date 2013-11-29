class AddPriceToProductVariant < ActiveRecord::Migration
  def change
    add_column :product_variants, :price, :decimal
  end
end
