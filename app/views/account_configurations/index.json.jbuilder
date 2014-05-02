json.array!(@account_configurations) do |account_configuration|
  json.extract! account_configuration, :id, :user_id, :allow_netting, :collection_mail_frecuency_in_days
  json.url account_configuration_url(account_configuration, format: :json)
end
