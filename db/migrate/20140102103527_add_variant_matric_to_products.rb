class AddVariantMatricToProducts < ActiveRecord::Migration
  def change
    add_column :products, :variant_matric, :string
  end
end
