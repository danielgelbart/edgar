json.array!(@filings) do |filing|
  json.extract! filing, :id, :stock_id, :type, :acn, :year
  json.url filing_url(filing, format: :json)
end
