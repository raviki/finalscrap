class AccountsController < ApplicationController
  def index
    
    @user =current_user
    @addresses = Address.find_by(:user_id => @user.id)
     
  end
end
