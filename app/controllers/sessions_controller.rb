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
   
   puts "---***#{params[:session][:session_login]}" 
   user = CustomerManagement.find_by(:email => params[:session][:session_login])
    
   if !user
     user = CustomerManagement.find_by(:mobile_number => params[:session][:session_login])
   end
   # user = user.downcase
   if user
     puts "1"
    @user_hash= BCrypt::Password.new(user.password)
    puts "user name #{user.name}"
    puts "Session password #{params[:session][:password]}"
    puts "user hash #{@user_hash}"
    puts "user password #{user.password}"
    if @user_hash == params[:session][:password]
      remember_token = user.new_remember_token
      session[:user_id] = user.id
      puts "remember_token #{remember_token}"
      if params[:session][:remember_me]
        cookies.permanent[:remember_token] = remember_token
      else
        cookies[:remember_token] = remember_token
      end
      encrypted_token = user.encrypt_token(remember_token)
      user.update_columns(remember_token: :encrypted_token)
      redirect_back_or(categories_path, :success  => "Logged In!!")   
    else
      puts "2"
      #puts "#{user_hash} this is not #{params.inspect}"
     render "new"
    end
   else 
     puts "3"
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
  puts "----:remember_token --- #{cookies[:remember_token]}"
  store_location()
 
  cookies.delete(:remember_token)
  
  session[:customer_id] = nil
  puts "----:remember_token --- #{cookies[:remember_token]}"
  redirect_back_or(root_url, :success => "Logged Out!!")
  end

end
 

  
