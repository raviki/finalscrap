json.array!(@customer_groups) do |customer_group|
  json.extract! customer_group, :description, :permission_level
  json.url customer_group_url(customer_group, format: :json)
end
