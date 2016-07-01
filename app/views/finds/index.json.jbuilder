json.array!(@finds) do |find|
  json.extract! find, :id, :game_id, :player_id, :plate_id, :points
  json.url find_url(find, format: :json)
end
