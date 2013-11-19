class RemoveSlugToCategories < ActiveRecord::Migration
  def change
    remove_column :categories, :slug, :string
  end
end
