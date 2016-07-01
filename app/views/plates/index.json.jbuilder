json.array!(@plates) do |plate|
  json.extract! plate, :id, :state, :geocode
  json.url plate_url(plate, format: :json)
end
