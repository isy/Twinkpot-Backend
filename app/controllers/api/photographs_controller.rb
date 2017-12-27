class Api::PhotographsController < ApplicationController
  protect_from_forgery with: :null_session
  skip_before_action :authenticate_user_from_token!

  def fetch_tags
    @tags = Tag.where('name LIKE(?)', "%#{term_params}%").pluck(:name)
  end

  def fetch_posts
    @posts = Post.all.order('created_at DESC')
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
end
