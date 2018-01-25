json.set! :itinerary_lists do
  json.array! @itinerary_lists do |itinerary_list|
    json.extract! itinerary_list, :id, :itinerary_name
  end
end