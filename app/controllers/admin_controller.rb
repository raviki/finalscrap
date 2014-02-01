class AdminController < ApplicationController
  layout "admin"
  before_filter :verify_admin
  
  def index
       
  end
  
  def log
    Activity.log_activity(self.class, @user.id, @user.name, params[:id], params[:action],params.to_s)
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
    if signed_in?    
      if !current_user.role? :admin
        redirect_to :back
     elsif current_user.role? :admin
       return true
    end
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
