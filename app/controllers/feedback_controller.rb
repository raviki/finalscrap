class FeedbackController < ApplicationController
  def new
  end

  def create
    store_location()
    if (params[:mobile].present? && is_mobile_number(params[:mobile])) || (params[:email].present?)
      if params[:request].present? 

            UserMailer.feedback_request(params, current_user).deliver
            redirect_to root_url, notice: 'Thanks for Your Feedback. We are Looking Forward to Convert Your Inputs into Action.'  
      
      else
         redirect_back_or(root_url, alert: 'Please Enter Your Task discription. ')  
      end 
    else 
      redirect_back_or(root_url, notice: 'Please Enter a Valid 10 digit Mobile Number. ')   
    end
  end

end
