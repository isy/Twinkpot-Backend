class ApplicationController < ActionController::Base
  include AbstractController::Translation
  protect_from_forgery with: :exception
  # protect_from_forgery with: :null_session
  before_action :authenticate_user_from_token!
  before_action :detect_device

  def authenticate_user_from_token!
    auth_token = request.headers['Authorization']

    if auth_token
      authenticate_with_auth_token auth_token
    else
      authenticate_error
    end
  end

  private
  def authenticate_with_auth_token auth_token
    unless auth_token.include?(':')
      authenticate_error
      return
    end

    user_id = auth_token.split(':').first
    user = User.where(id: user_id).first

    if user && Devise.secure_compare(user.access_token, auth_token)
      sign_in user, store: false
    else
      authenticate_error
    end
  end

  def authenticate_error
    render json: { error: t('devise.failure.unauthenticated') }, status: 401
  end

  def detect_device
    case request.user_agent
      when /iPad/
        request.variant = :mobile
      when /iPod/
        request.variant = :mobile
      when /iPhone/
        request.variant = :mobile
      when /Android/
        request.variant = :mobile
    end
  end
end
