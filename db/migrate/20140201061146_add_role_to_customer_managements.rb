class AddRoleToCustomerManagements < ActiveRecord::Migration
  def change
    add_column :customer_managements, :role, :string
  end
end
