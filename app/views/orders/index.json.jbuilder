json.array!(@orders) do |order|
  json.extract! order, :customer_id, :voucher_id, :payment_id, :discount, :discount_message, :appointment_date, :duration_inHrs, :active
  json.url order_url(order, format: :json)
end
