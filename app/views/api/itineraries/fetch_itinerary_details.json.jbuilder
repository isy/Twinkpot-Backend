json.set! :itineraries do
  json.array! @itinerary_details do |itinerary|
    json.extract! itinerary, :id, :place_name, :latitude, :longitude
  end
end