json.array!(@items) do |item|
  json.extract! item, :id, :name, :description, :image_url, :user_id, :product_key, :type_id, :location, :quantity, :post_date
  json.url item_url(item, format: :json)
end
