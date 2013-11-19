class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.text :model
      t.integer :user_id
      t.string :user_name
      t.integer :belongsTo
      t.text :action_performed
      t.text :data

      t.timestamps
    end
  end
end
