class GameService

  def self.add_player(game,player, originator=false)
    return GamePlayer.create(game: game, player:player, originator: originator)
  end

  def self.points(game, player=nil)
    puts "finding points for player #{player} for game #{game}"
    if player
      finds = Find.where(player_id: player.id, game_id: game.id)
    else
      finds = Find.where(game_id: game.id)
    end
    puts finds.inspect
    return finds.map(&:points).inject(:+)
  end
end
