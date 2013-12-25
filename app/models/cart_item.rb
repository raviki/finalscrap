class CartItem < ActiveRecord::Base
  belongs_to :cart
  belongs_to :product_variant, :foreign_key => "product_id"
  has_one   :product,        :through => :product_variant
  
  validates :product_id,      :presence => true
  validates :price ,          :presence => true
  validates :quantity,        :presence => true
  
  def total_price 
    unit_price*quantity
  end  
  
  def unit_price
    return self.price + ((self.include_service == true)? product_variant.service_price: 0)
  end
  
  def unit_price_str
    return self.price.to_s + (((self.include_service == true) && (product_variant.service_price > 0))? " + "+product_variant.service_price.to_s: "")
  end
end
