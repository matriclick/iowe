json.array!(@currencies) do |currency|
  json.extract! currency, :id, :symbol, :fx_rate
  json.url currency_url(currency, format: :json)
end
