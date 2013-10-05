class OrderToProduct < ActiveRecord::Base
  belongs_to :product
  belongs_to :order
  belongs_to :store
    
  def updateShopId(storeId)
     self.update_attributes(:store_id =>  storeId)
  end
end
