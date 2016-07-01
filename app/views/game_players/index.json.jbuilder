json.array!(@game_players) do |game_player|
  json.extract! game_player, :id, :game_id, :player_id, :accepted
  json.url game_player_url(game_player, format: :json)
end
