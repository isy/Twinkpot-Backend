class HomeController < ApplicationController
  skip_before_action :authenticate_user_from_token!

  def index
  end

  def photo_new
    @post = Post.new
  end
end
