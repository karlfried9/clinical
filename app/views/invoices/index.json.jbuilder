json.array!(@invoices) do |invoice|
  json.extract! invoice, :id, :patient, :description, :status, :created_date, :mailing_address, :notes
  json.url invoice_url(invoice, format: :json)
end
