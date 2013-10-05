json.array!(@products) do |product|
  json.extract! product, :name, :image, :price, :description, :meta_description, :meta_keyword, :views, :active
  json.url product_url(product, format: :json)
end
