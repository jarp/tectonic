def login_as(player)
  puts "login as"
  session[:player_id] = player.id

  if @current_game
    GameService.add_player(@current_game, player, false, true)
    cookies[:current_game_id] = @current_game.id
  end
end
