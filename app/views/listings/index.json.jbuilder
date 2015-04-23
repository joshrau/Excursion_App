json.array!(@listings) do |listing|
  json.extract! listing, :id, :address, :alt, :category, :description, :directions, :hours, :lat, :long, :name, :price, :tag, :url, :phone, :email, :fax, :image1, :image2, :image3
  json.url listing_url(listing, format: :json)
end
