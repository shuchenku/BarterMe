json.array!(@items) do |item|
  json.extract! item, :id, :name, :description, :image_url, :user_id, :location, :quantity
  json.url item_url(item, format: :json)
end
