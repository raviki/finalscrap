class AddServicePriceToProductVariants < ActiveRecord::Migration
  def change
    add_column :product_variants, :service_price, :decimal
  end
end
