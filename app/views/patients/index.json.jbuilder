json.array!(@patients) do |patient|
  json.extract! patient, :id, :salutation, :first_name, :last_name, :patient_id, :date_of_birth, :notes, :user
  json.url patient_url(patient, format: :json)
end
