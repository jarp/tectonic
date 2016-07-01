class PlayController < ActivePlayerController
  def index
    @game = Game.find(cookies[:current_game_id])
    @players = @game.players
    @plates = Plate.all

    puts @game.plates.inspect
  end

  def table
    @game = Game.find(cookies[:current_game_id])
  end

  def set
    puts "setting game to id #{params[:id]}"
    cookies[:current_game_id] = params[:id]
    redirect_to current_game_path
  end
end
