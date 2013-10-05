class CreateCustomerLeads < ActiveRecord::Migration
  def change
    create_table :customer_leads do |t|
      t.text :type_name
      t.text :description

      t.timestamps
    end
  end
end
