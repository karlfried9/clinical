json.array!(@patient_activities) do |patient_activity|
  json.extract! patient_activity, :id, :patient_id, :clinical_trial, :activity_date, :body_part, :prescription_written, :prescription_notes, :amount_charged
  json.url patient_activity_url(patient_activity, format: :json)
end
