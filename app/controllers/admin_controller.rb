class AdminController < ApplicationController
  layout "admin"
  before_filter :verify_admin
  
  def index
       
  end
  
  def log
    Activity.log_activity(self.class, @user.id, @user.name, params[:id], params[:action],params)
  end
  
  
  
  def select_page
    self.store_location()
    @select_page = true
    self.redirect_back_or(request.fullpath)
  end
  
  private 
  
  def redirect_to(*args)
    flash.keep
    super
  end
  
  def verify_admin
    if !signed_in? 
     
       puts "verify_admin -------------1"
       session[:return_to] = request.url
       redirect_to sessions_path 
    elsif false && current_user.customer_group 
      puts "verify_admin -------------2"
      if current_user.customer_group.permission_level > 8
        puts "verify_admin -------------3"
        flash[:notice] = "Welcome Admin"
      else
        puts "verify_admin -------------4"
        session[:return_to] = request.url
        redirect_to sessions_path, notice: "Please login with admin login Id"
      end 
    else 
        puts "verify_admin -------------5"
       session[:return_to] = request.url
       redirect_to sessions_path          
    end
  end
  
 # redirect_to sessions_path
  
  def pagination_page
    params[:page] ||= 1
    params[:page].to_i
  end

  def pagination_rows
    params[:rows] ||= 10
    params[:rows].to_i
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
