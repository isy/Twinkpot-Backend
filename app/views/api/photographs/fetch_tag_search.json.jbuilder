json.set! :posts do
  json.array! @posts do |post|
    json.extract! post, :id, :place_name, :post_image, :created_at,
                  :updated_at, :caption
  end
end