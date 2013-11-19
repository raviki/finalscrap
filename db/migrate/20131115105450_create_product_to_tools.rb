class CreateProductToTools < ActiveRecord::Migration
  def change
    create_table :product_to_tools do |t|
      t.integer :product_id
      t.integer :tool_id

      t.timestamps
    end
  end
end
