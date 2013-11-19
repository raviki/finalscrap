class CheckoutController < ApplicationController

  def index
    require_user()
    
    @cart = current_cart
    @cart_items= CartItem.all
    @address = Address.new
  end
  def new
  end

  def show
  end
  
  def create
     user = current_user
     if user
       @user_hash= BCrypt::Password.new(user.password) 
       if @user_hash== params[:password]
         puts"success"
         
       else
         flash
         redirect_to :back
       end
     end
  end
end
