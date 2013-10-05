class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.integer :customer_id
      t.text :keys

      t.timestamps
    end
  end
end
