json.array!(@homepages) do |homepage|
  json.extract! homepage, :id, :title, :description
  json.url homepage_url(homepage, format: :json)
end
