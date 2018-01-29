if Rails.env.production?
  Twinkpot::Application.config.session_store :redis_store, servers: ENV['REDIS_URL']
end