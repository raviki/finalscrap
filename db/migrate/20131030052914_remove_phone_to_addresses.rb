class RemovePhoneToAddresses < ActiveRecord::Migration
  def change
    remove_column :addresses, :phone, :integer
  end
end
