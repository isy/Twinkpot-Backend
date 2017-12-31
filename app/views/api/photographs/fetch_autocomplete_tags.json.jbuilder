json.array! @tags do |tag|
  json.extract! tag, :name, :post_count
end