class OrderRequestsController < ApplicationController
  def create
    store_location()
    if params[:mobile].present?
      if params[:request].present? 
        @category = Category.find(params[:category_id])
        if @category
            UserMailer.order_request(params, @category.name, current_user).deliver
            redirect_back_or(root_url, notice: 'We have recieved your request. We will get back to you within 24 Hrs. ')   
        else 
            redirect_back_or(root_url, notice: 'Please enter Task type. ')
        end        
      else
         redirect_back_or(root_url, alert: 'Please enter your Task discription. ')  
      end 
    else 
      redirect_back_or(root_url, notice: 'Please enter a valid Phone Number. ')   
    end
  end
end
