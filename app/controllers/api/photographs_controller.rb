class Api::PhotographsController < ApiController
  protect_from_forgery with: :null_session
  skip_before_action :authenticate_user_from_token!
  skip_before_action :verify_authenticity_token, only: %i(post_like delete_like)

  def fetch_tags
    @tags = Tag.where('name LIKE _utf8mb4? COLLATE utf8mb4_unicode_ci', "%#{term_params}%").pluck(:name)
  end

  def fetch_popular_tag
    @tags = Tag.find(PostTag.group(:tag_id).order('count(tag_id) desc').limit(20).pluck(:tag_id))
    render :fetch_tags
  end

  def fetch_autocomplete_tags
    @tags = Tag.select_tag_column.with_post_tag.search_like_tag(term_params)
  end

  def fetch_category
    @categories = Category.all
  end

  def fetch_city
    @cities = PrefectureCity.where(prefecture: prefecture_params)
  end

  def fetch_refine_posts
    if refine_post_params[:prefecture].empty? && refine_post_params[:category].empty?
      @posts = Post.all
    elsif refine_post_params[:prefecture].empty? && refine_post_params[:category].present? && refine_post_params[:city].empty?
      @posts = Post.where(category_id: refine_post_params[:category]).order('created_at DESC')
    elsif refine_post_params[:prefecture].present? && refine_post_params[:category].empty? && refine_post_params[:city].empty?
      @posts = Post.where(prefectures: refine_post_params[:prefecture]).order('created_at DESC')
    elsif refine_post_params[:prefecture].present? && refine_post_params[:category].present? && refine_post_params[:city].empty?
      @posts = Post.where(prefectures: refine_post_params[:prefecture]).where(category_id: refine_post_params[:category]).order('created_at DESC')
    elsif refine_post_params[:city].present? && refine_post_params[:category].empty?
      @posts = Post.where(prefectures: refine_post_params[:prefecture]).where(city: refine_post_params[:city]).order('created_at DESC')
    else
      @posts = Post.where(prefectures: refine_post_params[:prefecture]).where(city: refine_post_params[:city]).where(category_id: refine_post_params[:category]).order('created_at DESC')
    end
    render :fetch_posts
  end

  def fetch_posts
    @posts = Post.all.order('created_at DESC')
  end

  def fetch_limit_posts
    @posts = Post.all.limit(10).order('created_at DESC')
    render :fetch_posts
  end

  def fetch_user_rank
    @users = User.find(Like.group(:user_id).order('count(user_id) desc').limit(5).pluck(:user_id))
  end

  def fetch_popular_posts
    @posts = Post.find(Like.group(:post_id).order('count(post_id) desc').limit(10).pluck(:post_id))
    render :fetch_posts
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
    @place = Post.select(:place_name, :prefectures, :city, :latitude, :longitude).find_by(place_name: place_name_params)
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

  def prefecture_params
    params.require(:prefecture)
  end

  def refine_post_params
    params.permit(:prefecture, :city, :category)
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
