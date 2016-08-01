class Api::GamesController < GamesController
  def index
    puts "getting stuff that is #{params}"
    @games = params[:status] == 'completed' ? @active_player.games.completed : @active_player.games.active
  end
  def show
  end
end
