class SessionsController < ApplicationController

def index
  session[:customer_id] = nil
  if current_user
      redirect_to root_url
  else
    store_location()
    render 'new' 
  end 
end
  def new
      store_location()
  end
  

 def create
  if env["omniauth.auth"].present?  
        facebook_callback()
  else
   
   user = CustomerManagement.find_by(:email => params[:session][:session_login])
    
   if !user
     user = CustomerManagement.find_by(:mobile_number => params[:session][:session_login])
   end
   # user = user.downcase
   if user
    @user_hash= BCrypt::Password.new(user.password)
    if @user_hash == params[:session][:password]
      remember_token = user.new_remember_token
      session[:user_id] = user.id
      if params[:session][:remember_me]
        cookies.permanent[:remember_token] = remember_token
      else
        cookies[:remember_token] = remember_token
      end
      encrypted_token = user.encrypt_token(remember_token)
      user.update_columns(remember_token: encrypted_token)
      if user.provider == "self_mobile_reset"
        redirect_to edit_password_reset_url(user.password_reset_token)  
      else
        redirect_back_or(categories_path, :success  => "Logged In!!")   
      end
    else
     #puts "#{user_hash} this is not #{params.inspect}"
     flash[:notice] = 'Invalid Email / Password Combination. Enter valid data/Reset Your Password' # Not quite right!
     render "new"
    end
   else 
     # Create an error message and re-render the signin form.
     flash[:notice] = 'Invalid Email / Password Combination' # Not quite right!
     render 'new'
   end
  end
end

  def facebook_callback
    @customerManagement = CustomerManagement.where(:email => env["omniauth.auth"].extra.raw_info.email).first
    if @customerManagement
      @customerManagement.update_facebook_omniauth(env["omniauth.auth"])
      @customerManagement.save      
    else      
      @customerManagement = CustomerManagement.from_omniauth(env["omniauth.auth"])   
    end 
    session[:customer_id] = @customerManagement.id    
     
    redirect_back_or(categories_path)
  end

def destroy
  store_location()
  cookies.delete(:remember_token)
  session[:customer_id] = nil
  redirect_back_or(root_url, :success => "Logged Out!!")
  end

end
 

  
