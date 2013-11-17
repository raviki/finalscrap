class OrderRequestsController < ApplicationController
  def create
    store_location()
    
    redirect_back_or(root_url, notice: 'We have recieved your request. We will get back to you within 24 Hrs. ') 
  end
end
