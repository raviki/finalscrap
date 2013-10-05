class CreateCustomerGroups < ActiveRecord::Migration
  def change
    create_table :customer_groups do |t|
      t.text :description
      t.integer :permission_level

      t.timestamps
    end
  end
end
