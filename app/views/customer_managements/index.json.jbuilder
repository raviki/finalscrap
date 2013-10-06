json.array!(@customer_managements) do |customer_management|
  json.extract! customer_management, :name, :password, :email, :customer_id, :remember_token, :password_digest, :provider, :uid, :oauth_token, :oauth_expires_at
  json.url customer_management_url(customer_management, format: :json)
end
