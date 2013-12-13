class AddCustomerGroupIdToCustomerManagements < ActiveRecord::Migration
  def change
    add_column :customer_managements, :customer_group_id, :integer
  end
end
