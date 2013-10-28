class Address < ActiveRecord::Base
validates :address, :presence => true
validates :name, :presence => true
validates :pin, :presence => true
validates :phone, :presence => true
validates :user_id, :presence => true

belongs_to :customer_managements

end
