class AddUserIdToAdresses < ActiveRecord::Migration
  def change
    add_column :adresses, :user_id, :integer
  end
end
