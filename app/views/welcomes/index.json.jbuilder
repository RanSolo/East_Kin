json.array!(@welcomes) do |welcome|
  json.extract! welcome, :id, :bandName, :headline, :message, :logo, :restart_count =
  json.url welcome_url(welcome, format: :json)
end
