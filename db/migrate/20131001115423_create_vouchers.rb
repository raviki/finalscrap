class CreateVouchers < ActiveRecord::Migration
  def change
    create_table :vouchers do |t|
      t.text :description
      t.integer :customer_group_id
      t.integer :type_name
      t.decimal :value
      t.date :validity_till
      t.boolean :active

      t.timestamps
    end
  end
end
