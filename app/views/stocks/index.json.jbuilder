json.array!(@stocks) do |stock|
  json.extract! stock, :id, :nam, :ticker, :cik
  json.url stock_url(stock, format: :json)
end
