json.array!(@activities) do |activity|
  json.extract! activity, :id, :name, :category, :subcategory, :billable, :amount, :description
  json.url activity_url(activity, format: :json)
end
