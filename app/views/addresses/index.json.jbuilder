json.array!(@addresses) do |address|
  json.extract! address, :name, :address, :city, :pin, :phone, :email
  json.url address_url(address, format: :json)
end
