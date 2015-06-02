json.array!(@clinical_trials) do |clinical_trial|
  json.extract! clinical_trial, :id, :name, :stage, :start_date
  json.url clinical_trial_url(clinical_trial, format: :json)
end
