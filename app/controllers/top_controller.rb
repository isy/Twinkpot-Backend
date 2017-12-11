class TopController < ApplicationController
  skip_before_action :authenticate_user_from_token!

  def index
  end
end
