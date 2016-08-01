json.array!(@games) do |game|
  json.extract! game, :id, :title, :created_at, :updated_at, :is_completed
  json.total_finds game.plates.count
  json.players game.players do |player|
    json.first_name player.first_name
    json.last_name player.last_name
    json.email player.email
  end


end
