json.set! :users do
  json.array! @users do |user|
    json.extract! user, :id, :user_name, :user_image
  end
end