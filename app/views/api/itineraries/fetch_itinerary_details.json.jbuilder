json.set! :itineraries do
  json.array! @itinerary_details do |itinerary|
    json.extract! itinerary, :place_name, :latitude, :longitude
  end
end