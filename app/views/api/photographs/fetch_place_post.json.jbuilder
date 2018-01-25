json.set! :place_posts do
  json.extract! @place, :place_name, :latitude, :longitude
  json.posts @posts, :id, :place_name, :post_image, :created_at,
      :updated_at, :caption
end
