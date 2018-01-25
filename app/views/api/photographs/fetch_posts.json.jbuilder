json.set! :posts do
  json.array! @posts do |post|
    json.extract! post, :id, :place_name, :post_image, :created_at,
                  :updated_at, :caption
    if user_signed_in?
      @like = post.isLike_user?(current_user)
    end
    json.isLike @like
  end
end