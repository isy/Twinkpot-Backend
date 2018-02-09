class UsersController < ApplicationController
  def show
    @user = User.find_by(user_name: params[:user_name])
    @posts = @user.posts.order('created_at desc')
  end

  def post_delete
    post = Post.find_by(post_delete_params)
    if post.destroy
      flash[:notice] = '投稿を削除しました'
    else
      flash[:error] = '投稿を削除できませんでした'
    end
    redirect_to user_path(current_user.user_name)
  end

  def edit

  end

  def update
    if current_user.update(update_params)
      flash[:notice] = 'プロフィールを編集しました'
      redirect_to user_path(current_user.user_name)
    else
      flash[:error] = 'プロフィールを編集できませんでした'
      render edit_user_path
    end
  end

  def itinerary

  end

  private
  def update_params
    params.require(:user).permit(:user_image, :user_name, :prefectures, :profile, :gender, :birthday)
  end

  def post_delete_params
    params.permit(:id)
  end
end
