class ProductVariant < ActiveRecord::Base
  belongs_to :product, :foreign_key => "product_id"
  has_many :cart_items
  has_many :order_to_product 
  
  validates :price,                 :presence => true,          :numericality => true
  
  def display_name
    name = ""
    if self.brand
      name = name+"["+self.brand+"] "
    end 
   return name+self.value + " (Rs. " + self.price.to_s+")"
  end
end
