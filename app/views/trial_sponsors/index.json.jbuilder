json.array!(@trial_sponsors) do |trial_sponsor|
  json.extract! trial_sponsor, :id, :name, :contact_info
  json.url trial_sponsor_url(trial_sponsor, format: :json)
end
