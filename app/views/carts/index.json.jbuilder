json.array!(@carts) do |cart|
  json.extract! cart, :customer_id
  json.url cart_url(cart, format: :json)
end
