json.array!(@tours) do |tour|
  json.extract! tour, :id, :name, :start_on, :end_on, :player_id
  json.url tour_url(tour, format: :json)
end
