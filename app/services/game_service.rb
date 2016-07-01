class GameService

  def self.add_player(game,player, originator=false)
    return GamePlayer.create(game: game, player:player, originator: originator)
  end
end
