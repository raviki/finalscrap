class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  include SessionsHelper
  
  private 
  
  def pagination_page
    params[:page] ||= 1
    params[:page].to_i
  end

  def pagination_rows
    params[:rows] ||= 10
    params[:rows].to_i
  end
  
  def current_user
    @current_user ||= Customer.find(session[:customer_id]) if session[:customer_id]
  end
  
  def store_location
    session[:return_to] = request.env["HTTP_REFERER"] 
    
  end

  def redirect_back_or(default, hsh = {})
     redirect_to(session[:return_to] || default, hsh )
     clear_return_to
  end

  def clear_return_to
   session[:return_to] = nil
  end
  
   def current_cart
    puts "------------------------------------In current cart-----------------"
    if cookies[:cart_id]
      puts "-----------Cant come here------------"
      @cart = Cart.find_by(:customer_id => cookies[:cart_id])
      puts "---------cart not existing #{@cart}"
      unless @cart
        puts "so creating .............. cart new"
        @cart = Cart.new(:customer_id => cookies[:cart_id])
        cookies.permanent[:cart_id] = @cart.customer_id
      end
    end
    @current_user = current_user
    if @current_user
      if @cart
        @cart.update(:customer_id => @current_user.id)
      else
        @cart = Cart.find_by(:customer_id => @current_user.id)
        unless @cart
          @cart = Cart.new(:customer_id => @current_user.id)
          cookies.permanent[:cart_id] = @cart.customer_id
        end
      end
    else
      unless @cart
        @cart = Cart.create(:customer_id => rand(1990))
        cookies[:cart_id] = @cart.customer_id
      end
    end
    return @cart
  end

  def current_user
    rem_token_cookie = cookies[:remember_token]
    encrypted_token  = Digest::SHA1.hexdigest(rem_token_cookie.to_s)
    @current_user ||= CustomerManagement.find_by(:remember_token => :encrypted_token)
    puts " CUrrent user:#{@current_user}"
    return @current_user
  end

  
end
