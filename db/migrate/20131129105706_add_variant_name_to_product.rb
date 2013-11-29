class AddVariantNameToProduct < ActiveRecord::Migration
  def change
    add_column :products, :variant_name, :string
  end
end
