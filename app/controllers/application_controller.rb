class ApplicationController < ActionController::Base
  include AbstractController::Translation
  protect_from_forgery with: :exception
  # protect_from_forgery with: :null_session
  before_action :detect_device

  def after_sign_in_path_for(resource)
    home_index_path # ログイン後に遷移するpath
  end

  def after_sign_out_path_for(resource)
    root_path # ログアウト後に遷移するpath
  end

  private
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
