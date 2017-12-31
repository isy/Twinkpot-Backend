class Api::PhotographsController < ApplicationController
  protect_from_forgery with: :null_session
  skip_before_action :authenticate_user_from_token!

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
  end

  def fetch_tag_search
    tag = Tag.find_by(name: tag_params)
    @posts = tag.try(:posts)
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
end
