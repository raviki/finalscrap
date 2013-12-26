class UserMailer < ActionMailer::Base
  default from: "customercare@evertask.in"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user)
    @user = user
    mail :to => user.email, :subject => "Password Reset"
  end
  
  def order_request(params, name, user)
    @mobile = params[:mobile]
    @request = params[:request]
    @category_name = name
    @user = user
   
    mail :to => I18n.t(:admin_email), :subject => "Order Request - "+@category_name
  end
  
  def welcome_mail(user)
    @user = user
    @phone_number = I18n.t(:company_phone)
    mail :to => user.email, :subject => "Welcome to EVERTASK"
  end
  
  def order_confirmation(user, order)
    @order = order
    mail(:to => user.email, :subject => "Order Confirmation") do |format|
      format.html { render :template => 'orders/show' }
    end
  end
end
