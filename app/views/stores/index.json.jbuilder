json.array!(@stores) do |store|
  json.extract! store, :name, :contact_name, :contact_no, :address, :pin, :review, :rating, :active
  json.url store_url(store, format: :json)
end
