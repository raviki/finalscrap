class AddCustomerLeadIdToCustomerManagements < ActiveRecord::Migration
  def change
    add_column :customer_managements, :customer_lead_id, :integer
  end
end
