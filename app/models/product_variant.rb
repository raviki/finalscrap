class ProductVariant < ActiveRecord::Base
  belongs_to :product, :foreign_key => "product_id"
  has_many :cart_items
  
  validates :price,                 :presence => true,          :numericality => true
end
