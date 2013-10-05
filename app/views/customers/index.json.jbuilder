json.array!(@customers) do |customer|
  json.extract! customer, :first_name, :second_name, :contact_no, :add_line1, :add_line2, :city, :pin, :wishlist, :customer_group_id, :customer_lead_id
  json.url customer_url(customer, format: :json)
end
