class PasswordResetsController < ApplicationController
  def create
    if params[:email] != ""
      user = CustomerManagement.find_by_email(params[:email])
    end
    if user 
      user.send_password_reset 
      redirect_to sessions_path, :notice => "Email sent with password reset instructions."
    else
      user = CustomerManagement.find_by_mobile_number(params[:mobile])
       if user 
        user.send_password_reset_4mobile
        redirect_to sessions_path, :notice => "New One Time Password is sent to Your Mobile. It is valid for only 2 Hours."
      else
        redirect_to new_password_reset_path, :notice => "User not Found."
      end 
    end
  end

  def edit
    @user = CustomerManagement.find_by_password_reset_token!(params[:id])
  end

  def update
    @user = CustomerManagement.find_by_password_reset_token!(params[:id])

    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_resets_path, :alert => "Password reset has expired."
    elsif params[:customer_management][:password] == params[:customer_management][:password_confirmation]
      @user.password = params[:customer_management][:password]
      @user.provider = "manual_mobile_password_reset"
      if  @user.save(:validate => false)       
        redirect_back_or(sessions_path, :notice => "Password has been reset!")
      end
    else
      render :new
    end
  end
end