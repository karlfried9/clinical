json.array!(@clinical_trial_visits) do |clinical_trial_visit|
  json.extract! clinical_trial_visit, :id
  json.url clinical_trial_visit_url(clinical_trial_visit, format: :json)
end
