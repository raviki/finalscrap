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
  
end
