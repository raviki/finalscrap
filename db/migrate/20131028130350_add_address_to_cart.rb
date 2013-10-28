class AddAddressToCart < ActiveRecord::Migration
  def change
    add_column :carts, :address, :integer
  end
end
