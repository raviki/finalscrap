class AddAppointmentTimeToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :appointment_time, :timestamp
  end
end
