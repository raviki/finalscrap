class AccountsController < ApplicationController
  def index
    require_user()
    @user =current_user
    if @user
      @addresses = Address.find_by(:user_id => @user.id)
    end 
  end
end
