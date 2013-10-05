class Wishlist < ActiveRecord::Base
  belongs_to :wishCustomer,         :class_name => "Customer",        :foreign_key => "customer_id"
  belongs_to  

end
