json.set! :itinerary_places do
  json.array! @places do |place|
    json.place place, :place_name, :post_image
  end
end