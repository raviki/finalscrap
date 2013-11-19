class RemoveAddressToCarts < ActiveRecord::Migration
  def change
    remove_column :carts, :address, :integer
  end
end
