json.set! :post do
  json.extract! @post, :id, :place_name, :country, :prefectures, :city, :postal_code, :latitude, :longitude, :post_image, :created_at,
                  :updated_at, :caption
    json.user @post.user, :id, :user_name, :user_image
    json.tags @post.tags, :id, :name
    json.like @like
    json.likeCount @count
  # json.array! @post.tags do |tag|
      #   json.tag tag, :name
      # end
end
