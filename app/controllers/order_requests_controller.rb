class OrderRequestsController < ApplicationController
  def create
    store_location()
    if params[:mobile].present? && is_mobile_number(params[:mobile])
      if params[:request].present? 
        @category = Category.find(params[:category_id])
        if @category
            UserMailer.order_request(params, @category.name, current_user).deliver
            redirect_back_or(root_url, notice: 'We have recieved your request. We will get back to you within 24 Hrs. ')   
        else 
            redirect_back_or(root_url, notice: 'Please Enter Task Type. ')
        end        
      else
         redirect_back_or(root_url, alert: 'Please Enter Your Task discription. ')  
      end 
    else 
      redirect_back_or(root_url, notice: 'Please Enter a Valid 10 digit Mobile Number. ')   
    end
  end
end
