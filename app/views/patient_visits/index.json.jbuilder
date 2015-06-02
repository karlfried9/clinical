json.array!(@patient_visits) do |patient_visit|
  json.extract! patient_visit, :id
  json.url patient_visit_url(patient_visit, format: :json)
end
