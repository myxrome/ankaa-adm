json.array!(@values) do |value|
  json.extract! value, 
  json.url value_url(value, format: :json)
end
