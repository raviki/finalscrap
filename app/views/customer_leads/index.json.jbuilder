json.array!(@customer_leads) do |customer_lead|
  json.extract! customer_lead, :type_name, :description
  json.url customer_lead_url(customer_lead, format: :json)
end
