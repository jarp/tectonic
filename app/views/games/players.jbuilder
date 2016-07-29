json.array!(@players) do |player|
  json.firstname player.first_name
  json.lastname player.last_name
  json.id player.id
  json.imageurl = player.image
  json.email = player.email
end
