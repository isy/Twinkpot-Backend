class ApplicationController < ActionController::Base
  include AbstractController::Translation
  protect_from_forgery with: :exception
  # protect_from_forgery with: :null_session
  before_action :detect_device

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
