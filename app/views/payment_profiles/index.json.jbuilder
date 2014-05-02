json.array!(@payment_profiles) do |payment_profile|
  json.extract! payment_profile, :id, :bank_name, :account_number, :account_type, :rut
  json.url payment_profile_url(payment_profile, format: :json)
end
