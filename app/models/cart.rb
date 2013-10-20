class Cart < ActiveRecord::Base
  has_many :cart_items, :dependent => :destroy
  belongs_to :customer_managements
  def add_products(params)
    
    puts "Helloooooooo addding to cart"
    params.each_pair {|key,value| puts "#{key} = #{value}"}
    
    
    current_item = CartItem.find_by(:product_id => params[:product_id])
    
    puts "Currrent item #{current_item}"
    
    if current_item
      current_item.quantity += params[:quantity].to_i
    else
      current_item = cart_items.new(params)
    end
    return current_item
  end
end
