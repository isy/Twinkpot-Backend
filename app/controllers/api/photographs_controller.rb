class Api::PhotographsController < ApiController
  protect_from_forgery with: :null_session
  skip_before_action :authenticate_user_from_token!
  skip_before_action :verify_authenticity_token, only: %i(post_like delete_like)

  def fetch_tags
    @tags = Tag.where('name LIKE _utf8mb4? COLLATE utf8mb4_unicode_ci', "%#{term_params}%").pluck(:name)
  end

  def fetch_autocomplete_tags
    @tags = Tag.select_tag_column.with_post_tag.search_like_tag(term_params)
  end

  def fetch_posts
    @posts = Post.all.order('created_at DESC')
  end

  def fetch_show_post
    @post = Post.find(post_id_params)
    @count = @post.likes.count
    if user_signed_in?
      @like = @post.isLike_user?(current_user)
    end
  end

  def fetch_tag_search
    tag = Tag.find_by(name: tag_params)
    @posts = tag.try(:posts)
  end

  def fetch_place_post
    @place = Post.select(:place_name, :latitude, :longitude).find_by(place_name: place_name_params)
    @posts = Post.where(place_name: place_name_params)
  end

  def post_like
    @like = Like.new(post_like_params)

    if @like.save
      render json: nil, status: :created
    else
      render json: @like.errors, status: :unprocessable_entity
    end
  end

  def delete_like
    @like = Like.find_by(user_id: current_user.id, post_id: post_id_params)

    if @like.destroy
      head :no_content
    else
      render json: @like.errors, status: :unprocessable_entity
    end
  end

  private
  def term_params
    params.require(:term)
  end

  def tag_params
    params.require(:tag_name)
  end

  def post_id_params
    params.require(:post_id)
  end

  def place_name_params
    params.require(:name)
  end

  def post_like_params
    params.require(:like).permit(:post_id).merge(user_id: current_user.id)
  end

end
