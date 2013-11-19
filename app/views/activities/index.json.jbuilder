json.array!(@activities) do |activity|
  json.extract! activity, :model, :user_id, :user_name, :belongsTo, :action_performed, :data
  json.url activity_url(activity, format: :json)
end
