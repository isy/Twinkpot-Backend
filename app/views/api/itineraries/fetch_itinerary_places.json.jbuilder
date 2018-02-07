json.set! :itinerary_places do
  json.array! @places do |place|
    json.place place, :place_name, :post_image, :address, :postal_code, :tel
  end
end