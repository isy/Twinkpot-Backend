json.set! :post do
  json.extract! @post, :id, :place_name, :post_image, :created_at,
                  :updated_at, :caption
end