class PlayController < ActivePlayerController
  layout 'play'
  before_action :get_current_game, except: [:set]

  def index
    @current_plates = @current_game.plates
    @players = @current_game.players
    @plates = Plate.all
    @finds = @current_game.finds
    @table = Table.new(@current_game)
    @leaders = @table.leaders
    @percent_done = ((@finds.count.to_f / @plates.count.to_f) * 100).round

    # When a user hits the current page, announce their arrival.
    ActionCable.server.broadcast "game_channel_#{cookies["current_game_id"]}",
    player: @active_player,
    action: "join"
  end

  def table
    @leaders = Table.new(@current_game).leaders
  end

  def timeline
    @timeline = Timeline.where(game: @current_game)
  end

  def set
    cookies[:current_game_id] = params[:id]
    redirect_to current_game_path
  end


  private

  def get_current_game
    if cookies[:current_game_id]
      @current_game = Game.includes(:players, :finds).find(cookies[:current_game_id])
    else
      flash[:message] = "You need to be part of an active game..."
      redirect_to games_path
    end
  end
end
