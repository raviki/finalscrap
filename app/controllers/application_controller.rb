class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  include SessionsHelper
  add_breadcrumb "Home", :root_path

  
  private
  def pagination_page
    params[:page] ||= 1
    params[:page].to_i
  end

  def pagination_rows
    params[:rows] ||= 16
    params[:rows].to_i
  end
  
  def is_mobile_number(phone)
    return ((phone =~ /^\d{10}$/) && (phone.to_i >= 999999999))
  end

  
  def require_user
    if !current_user
      if cookies[:require_user_page]
        redirect_to root_url
      else
        store_location("false")
        redirect_to sessions_path 
      end
      cookies.delete(:require_user_page) 
    else      
      cookies[:require_user_page] = true
    end
  end
  
  def store_location(next_page = nil)
    if !session[:return_to].present?
      disallowed_urls = [ sessions_path, log_out_url ]
      disallowed_urls.map!{|url| url[/\/\w+$/]}
      if !next_page
        unless disallowed_urls.include?(request.env["HTTP_REFERER"])
          session[:return_to] = request.env["HTTP_REFERER"]
        end
      else 
        unless disallowed_urls.include?(request.url)
          session[:return_to] = request.url
        end
      end
     end
  end

  def redirect_back_or(default, hsh = {})
    redirect_to(session[:return_to] || default, hsh )
    clear_return_to
  end

  def clear_return_to
    session[:return_to] = nil
  end

 def current_cart
    if cookies[:cart_customer_id]
      @cart = Cart.find_by(:customer_id => cookies[:cart_customer_id])
    end
    @current_user = current_user
    if @current_user
      if @cart
        if @cart.customer_id != @current_user.id
          @user_cart = Cart.find_by(:customer_id => @current_user.id)
          if @user_cart
            CartItem.where(:cart_id => @cart.id).update_all({:cart_id => @user_cart.id})
            @cart.delete
            @cart = @user_cart
          else
            @cart.update(:customer_id => @current_user.id)
          end
          cookies.delete :cart_customer_id
        end
      else
        @cart = Cart.find_or_create_by(:customer_id => @current_user.id)
      end

    else
      unless @cart
        @cart = Cart.create(:customer_id => rand(1990))
        cookies.permanent[:cart_customer_id] = @cart.customer_id
      end
    end

    return @cart
  end
  

  def current_user
    rem_token_cookie = cookies[:remember_token]
    if cookies[:remember_token]
      encrypted_token  = Digest::SHA1.hexdigest(rem_token_cookie.to_s)
      @current_user ||= CustomerManagement.find_by(:remember_token => :encrypted_token)
      return @current_user
    else
      if session[:customer_id]
        @current_user ||= CustomerManagement.find(session[:customer_id]) 
        return @current_user
      else
        return nil
      end 
    end
  end

  def update_cart_items
    @cart = current_cart
    @cart_items = @cart.cart_items
  end

end
