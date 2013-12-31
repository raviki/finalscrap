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
    return self.price 
  end
  
end
