def login_as(player)
  session[:player_id] = player.id
  GameService.add_player(@current_game, player, false, true)
  cookies[:current_game_id] = @current_game.id
end
