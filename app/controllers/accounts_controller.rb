class AccountsController < ApplicationController
  def index
    @address = Address.new
    @user =current_user
     
  end
end
