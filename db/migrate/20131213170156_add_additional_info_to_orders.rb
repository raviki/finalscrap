class AddAdditionalInfoToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :additional_info, :string
  end
end
