class AddMetaKeywordsToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :meta_keywords, :string
  end
end
