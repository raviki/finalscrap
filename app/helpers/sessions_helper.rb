
module SessionsHelper
  def signed_in?
   rem_token_cookie = cookies[:remember_token]
   print "Here I am in signed in and the token is #{rem_token_cookie}"
   encrypted_token  = Digest::SHA1.hexdigest(rem_token_cookie.to_s)
   puts "Encrypted Token #{encrypted_token}"
   if rem_token_cookie
      @user = CustomerManagement.find_by(:remember_token => :encrypted_token)
   elsif session[:customer_id]
      @user = Customer.find(session[:customer_id]) 
   else 
     return false
   end
   if @user
     return true
   else 
     return false
   end
 end
 end