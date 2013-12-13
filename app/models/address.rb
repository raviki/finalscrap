class Address < ActiveRecord::Base
has_many :carts
validates :address, :presence => true
validates :name, :presence => true
validates :pin, :presence => true
validates :phone, :presence => true
validates :user_id, :presence => true

belongs_to :customer_managements

  def full_address
    address = self.address+", "+self.city+", "+self.pin.to_s
    return address
  end

end
