json.array!(@categories) do |category|
  json.extract! category, :name, :image, :description, :active
  json.url category_url(category, format: :json)
end
