class Api::GamesController < GamesController
  def index
    @games = @active_player.games.active
  end
  def show
  end
end
