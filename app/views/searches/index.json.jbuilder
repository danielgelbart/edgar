json.array!(@searches) do |search|
  json.extract! search, :id, :filtype, :ticker
  json.url search_url(search, format: :json)
end
