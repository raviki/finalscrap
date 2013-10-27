json.array!(@product_variants) do |product_variant|
  json.extract! product_variant, :product_id, :value
  json.url product_variant_url(product_variant, format: :json)
end
