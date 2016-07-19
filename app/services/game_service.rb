class GameService

  def self.add_player(game,player, originator=false, accepted=false)
    return GamePlayer.where(game: game, player:player, originator: originator, accepted: accepted).first_or_create
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
