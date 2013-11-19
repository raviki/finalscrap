class AddHow2fixToProducts < ActiveRecord::Migration
  def change
    add_column :products, :how2fix, :text
  end
end
