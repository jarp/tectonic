class GameService

  def self.add_player(game, player, originator=false, accepted=false)
    return GamePlayer.where(game: game, player:player, originator: originator, accepted: accepted).first_or_create
  end

  def self.points(game, player=nil)
    puts "spoiling points for player #{player} for game #{game}"
    if player
      spoils = Spoil.where(player_id: player.id, game_id: game.id)
    else
      spoils = Spoil.where(game_id: game.id)
    end
    puts spoils.inspect
    return spoils.map(&:points).inject(:+)
  end
end
