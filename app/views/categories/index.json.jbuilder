json.array!(@categories) do |category|
  json.extract! category, :id, :name, :description, :similar_category, :item_id
  json.url category_url(category, format: :json)
end
