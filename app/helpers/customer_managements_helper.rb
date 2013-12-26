module CustomerManagementsHelper
  
  def sms_order_confirmation(user, order)
    message = "Your order #{order.id} is now confirmed, You will receive a call from our call center/Mr. Fixer to serve your request. EVERTASK #{contact_number}"
    recipient = user.mobile_number
    send_message(recipient, message) 
  end
  
  def sms_order_complete(user, order)
    message = "Your order #{order.id} is completed. If you like to share your feedback, Please give a missed call/send order Id as SMS to #{contact_number}. We will call you to take your valuable feedback. EVERTASK #{contact_number}"
    recipient = user.mobile_number
    send_message(recipient, message) 
  end
  
  def sms_welcome_message(user)
    message = "Welcome to EVERTASK. We are happy to serve you. To Place an Order, Call Us on #{contact_number}/Select the task in evertask.in - EVERTASK TEAM"
    recipient = user.mobile_number
    send_message(recipient, message)  
  end 
  
  def sms_password_reset(user, new_pwd)
    message = "Your One Time Password(OTP) for logging into everTask account is #{new_pwd}. It is valid for 2 hours. PLEASE DO NOT SHARE IT WITH ANYONE. EVERTASK #{contact_number}"
    recipient = user.mobile_number
    send_message(recipient, message)
  end
  
  def send_message(recipient, message_text)
    puts "Text Message to #{recipient}: #{message_text}"
  end
end
