json.array!(@spoils) do |spoil|
  json.extract! spoil, :id, :game_id, :player_id, :plate_id, :points
  json.url spoil_url(spoil, format: :json)
end
