json.array!(@vouchers) do |voucher|
  json.extract! voucher, :description, :customer_group_id, :type_name, :value, :validity_till, :active
  json.url voucher_url(voucher, format: :json)
end
