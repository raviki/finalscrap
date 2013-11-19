class AddAddressIdToCarts < ActiveRecord::Migration
  def change
    add_column :carts, :address_id, :integer
  end
end
