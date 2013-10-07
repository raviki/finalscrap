class PasswordResetsController < ApplicationController
  def create
    user = CustomerManagement.find_by_email(params[:email])
    user.send_password_reset if user
    redirect_to sessions_path, :notice => "Email sent with password reset instructions."
  end

  def edit
    @user = CustomerManagement.find_by_password_reset_token!(params[:id])
  end

  def update
    @user = CustomerManagement.find_by_password_reset_token!(params[:id])

    if @user.password_reset_sent_at < 2.hours.ago

      redirect_to new_password_reset_path, :alert => "Password reset has expired."
    elsif params[:customer_management][:password] == params[:customer_management][:password_confirmation]
      @user.password = params[:customer_management][:password]
      if  @user.save(:validate => false)
        redirect_to sessions_path, :notice => "Password has been reset!"
      end
    else
      render :new
    end
  end
end