class AddNameToAdresses < ActiveRecord::Migration
  def change
    add_column :adresses, :name, :string
  end
end
