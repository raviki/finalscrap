class Cart < ActiveRecord::Base
  has_many :cart_items, :dependent => :destroy
  belongs_to :customer_managements
  belongs_to :address
  
  def add_products(params)
    
    puts "Helloooooooo addding to cart"
    params.each_pair {|key,value| puts "#{key} = #{value}"}
      
    current_item = CartItem.find_by_product_id_and_cart_id(params[:product_id],params[:cart_id])
    
    puts "Currrent item #{current_item}"
    
    if current_item
      current_item.quantity += params[:quantity].to_i
    else
      current_item = cart_items.new(params)
    end
    
    current_item.include_service = params[:include_service]
    return current_item
  end
  
end
