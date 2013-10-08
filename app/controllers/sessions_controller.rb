class SessionsController < ApplicationController
def index
  session[:customer_id] = nil
  render 'new' 
end
  def new
  end

 def create
  user = CustomerManagement.find_by(:email => params[:session][:email])
 # user = user.downcase
 puts"User found #{user}"
 
  if user
    @user_hash= BCrypt::Password.new(user.password)
    if @user_hash== params[:session][:password]
      remember_token = user.new_remember_token
      session[:user_id] = user.id
      if params[:session][:remember_me]
        cookies.permanent[:remember_token] = remember_token
      else
        cookies[:remember_token] = remember_token
      end
      encrypted_token = user.encrypt_token(remember_token)
      user.update_columns(remember_token: :encrypted_token)
      redirect_to categories_path, :success  => "Logged In!!"    
    else
      #puts "#{user_hash} this is not #{params.inspect}"
     render "new"
     end
  else
    # Create an error message and re-render the signin form.
    flash.now[:error] = 'Invalid email/password combination' # Not quite right!
     render 'new'
  end
end
def destroy
  cookies.delete(:remember_token)
  session[:customer_id] = nil
  redirect_to categories_path, :success => "Logged Out!!"
  end

 end
 

  
