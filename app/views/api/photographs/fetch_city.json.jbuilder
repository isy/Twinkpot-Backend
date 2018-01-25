json.set! :cities do
  json.array! @cities do |city|
    json.extract! city, :code, :city
  end
end