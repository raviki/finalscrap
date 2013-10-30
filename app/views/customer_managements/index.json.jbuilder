json.array!(@customer_managements) do |customer_management|
  json.extract! customer_management, :name, :password, :email, :mobile_number, :customer_id, :remember_token, :password_digest, :provider, :uid, :oauth_token, :oauth_expires_at, :password_reset_token, :password_reset_sent_at
  json.url customer_management_url(customer_management, format: :json)
end
