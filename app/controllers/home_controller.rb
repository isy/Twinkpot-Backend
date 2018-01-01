class HomeController < ApplicationController

  def index
  end

  def photo_new
    @categories = Category.all
    @post = Post.new
  end

  def photo_create
    if post = Post.create(photo_create_params)
      tag_first_or_create(post, tag_params) if params[:tags]
      flash[:notice] = "投稿しました😍"
      redirect_to home_index_path
    else
      flash.now[:error] = "投稿に失敗しました😢"
      render('posts/photo_new')
    end
  end

  private
  def photo_create_params
    return params.require(:post).permit(:category_id, :place_id, :place_name, :remote_post_image_url, :caption).merge(user_id: current_user.id) unless params['post']['remote_post_image_url'].blank?
    params.require(:post).permit(:category_id, :place_id, :place_name, :post_image, :caption).merge(user_id: current_user.id)
  end

  def tag_params
    params.require(:tags)
  end

  def tag_first_or_create(post, tags)
    tags.each do |tag|
      hasTag = Tag.find_by(name: tag)
      if hasTag.present?
        post.post_tags.create(tag_id: hasTag.id)
      else
        post.tags.create(name: tag)
      end
    end
  end
end
