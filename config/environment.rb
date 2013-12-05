# Load the Rails application.
require File.expand_path('../application', __FILE__)
require "bootstrap-sass"

# Initialize the Rails application.
Website::Application.initialize!
  
 
  ActionMailer::Base.delivery_method = :smtp

  ActionMailer::Base.smtp_settings = {
   :address => "smtp.evertask.in",
   :port => 587,
   :domain => "evertask.in",
   :authentication => :login,
   :user_name => "customercare@evertask.in",
   :password => "Evertask2013",
   :authentication  =>"plain",
   :openssl_verify_mode => 'none',
   :enable_starttls_auto =>false
  }
 