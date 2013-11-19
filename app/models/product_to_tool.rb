class ProductToTool < ActiveRecord::Base
  belongs_to :product
  belongs_to :tool, :class_name => "Product"
end
