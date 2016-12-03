class Table
  def initialize(game, method='spoils')
    @game = game
    @table = @game.send(method).group_by { |f| f.player }
  end

  def leaders
    players = []
    with_points = []
    @table.each_pair do | p,f|
      totals = {player: p, states: []}
      with_points << p
      total_points = 0
      f.each do | spoil |
        total_points += spoil.points
        totals[:states] << {state: spoil.plate.code, points: spoil.points}
      end
      totals[:total_points] = total_points
      players << totals
    end

    @game.players.each do | player |
      players << {player: player, states: [], total_points: 0 } unless with_points.include? player
    end
    return players.sort_by {|p| p[:total_points]}.reverse
  end
end
