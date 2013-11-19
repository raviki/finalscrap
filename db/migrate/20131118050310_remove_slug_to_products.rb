class RemoveSlugToProducts < ActiveRecord::Migration
  def change
    remove_column :products, :slug, :string
  end
end
