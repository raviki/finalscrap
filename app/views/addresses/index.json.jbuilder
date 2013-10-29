json.array!(@addresses) do |address|
  json.extract! address, :address, :city, :pin, :phone, :email
  json.url address_url(address, format: :json)
end
