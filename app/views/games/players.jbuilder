json.array!(@players) do |player|
  json.id player.id
  json.firstname player.first_name
  json.lastname player.last_name
  json.email = player.email
  json.imageurl = player.image
end
