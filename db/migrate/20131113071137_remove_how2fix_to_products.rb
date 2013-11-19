class RemoveHow2fixToProducts < ActiveRecord::Migration
  def change
    remove_column :products, :how2fix, :string
  end
end
