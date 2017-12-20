class Api::PhotographsController < ApplicationController
  protect_from_forgery with: :null_session
  skip_before_action :authenticate_user_from_token!

  def fetch_tags
    @tags = Tag.where('name LIKE(?)', "%#{term_params}%").pluck(:name)
  end

  private
  def term_params
    params.require(:term)
  end
end
