class AddAppointmentTimeToCarts < ActiveRecord::Migration
  def change
    add_column :carts, :appointment_time, :timestamp
  end
end
