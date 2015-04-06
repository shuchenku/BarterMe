json.array!(@offers) do |offer|
  json.extract! offer, :id,:user1_id, :user2_id, :item1_id, :item2_id, :accepted
  json.url offer_url(offer, format: :json)
end
