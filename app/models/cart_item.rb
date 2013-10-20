class CartItem < ActiveRecord::Base
 belongs_to :cart
  belongs_to :product
  validates :product_id, :presence => true
  validates :price , :presence => true
  validates :quantity, :presence => true
  
  def total_price 
    product.price*quantity
  end 
end
