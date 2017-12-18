class HomeController < ApplicationController
  skip_before_action :authenticate_user_from_token!

  def index
  end

  def photo_new
    @categories = Category.all
    @post = Post.new
  end

  def photo_create
    if Post.create(photo_create_params)
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
end
