class Api::GamesController < GamesController
  def index
    @games = params[:status] == 'completed' ? @active_player.games.completed : @active_player.games.active
  end
  def show
  end
end