class Table
  def initialize(game)
    @game = game
    @table = @game.finds.group_by { |f| f.player }
  end

  def leaders
    players = []
    @table.each_pair do | p,f|
      totals = {player: p, states: []}
      total_points = 0
      f.each do | find |
        total_points += find.points
        totals[:states] << {state: find.plate.code, points: find.points}
      end
      totals[:total_points] = total_points
      players << totals
    end
    return players.sort_by {|p| p[:total_points]}.reverse
  end
end
