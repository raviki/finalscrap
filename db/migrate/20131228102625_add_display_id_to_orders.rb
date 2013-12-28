class AddDisplayIdToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :display_id, :string
  end
end
