class PlayController < ActivePlayerController

  before_action :get_active_game, except: [:set]

  def index
    @game = Game.find(cookies[:current_game_id])
    @players = @game.players
    @plates = Plate.all

    puts @game.plates.inspect
  end

  def table
    @game = Game.find(cookies[:current_game_id])
    @leaders = Table.new(@game).leaders
  end

  def map
    @game = Game.find(cookies[:current_game_id])
    gmaps = GoogleMapsService::Client.new(
        client_id: "<ENV['TECTONIC_CLIENT_ID'] %>",
        client_secret: "<ENV['TECTONIC_CLIENT_SECRET'] %>"
    )


    origins = []
    destinations = []
    matrix = gmaps.distance_matrix(origins, destinations,
        mode: 'driving',
        language: 'en-AU',
        avoid: 'tolls',
        units: 'imperial')
  end

  def set
    puts "setting game to id #{params[:id]}"
    cookies[:current_game_id] = params[:id]
    redirect_to current_game_path
  end


  private

  def get_active_game
    if cookies[:current_game_id]
      @game = Game.find(cookies[:current_game_id])
    else
      flash[:message] = "You need to be part of an active game..."
      redirect_to games_path
    end
  end
end
