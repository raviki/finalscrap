class OrderToProduct < ActiveRecord::Base
  belongs_to :product_variant, :foreign_key => "product_id"
  has_one :product, :through => :product_variant
  belongs_to :order
  belongs_to :store
  
  validates :quantity,                   :presence => true
    
  def updateShopId(storeId)
     self.update_attributes(:store_id =>  storeId)
  end
  
  def update_price_quantity(price, quantity, include_service)
    self.update_attributes(:quantity => self.quantity.to_i + quantity, :price => price, :include_service => include_service)
  end
end
