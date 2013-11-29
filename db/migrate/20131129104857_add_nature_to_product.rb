class AddNatureToProduct < ActiveRecord::Migration
  def change
    add_column :products, :nature, :string
  end
end
