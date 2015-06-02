json.array!(@payments) do |payment|
  json.extract! payment, :id, :invoice_id, :amount, :currency_code
  json.url payment_url(payment, format: :json)
end
