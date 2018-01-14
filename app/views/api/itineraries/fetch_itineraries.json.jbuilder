json.set! :itineraries do
  json.array! @itineraries do |itinerary|
    json.extract! itinerary, :id, :itinerary_name
  end
end