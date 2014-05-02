json.array!(@transactions) do |transaction|
  json.extract! transaction, :id, :debtor_id, :lender_id, :amount, :currency_id, :comments
  json.url transaction_url(transaction, format: :json)
end
