json.array!(@games) do |game|
  json.extract! game, :id, :title, :game_type_id
  json.url game_url(game, format: :json)
end
