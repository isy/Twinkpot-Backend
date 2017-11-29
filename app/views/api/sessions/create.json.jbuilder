json.set! :user do
  json.extract!@user, :id, :access_token
end