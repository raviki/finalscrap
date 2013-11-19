class UserMailer < ActionMailer::Base
  default from: "from@example.com"

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
end
