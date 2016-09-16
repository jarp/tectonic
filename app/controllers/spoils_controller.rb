require 'net/http'
require 'openssl'

class SpoilsController < ActivePlayerController
  before_action :set_spoil, only: [:show, :edit, :update, :destroy]
  before_action :set_current_game, only: [:create, :clear]

  # GET /spoils
  # GET /spoils.json
  def index
    @spoils = Spoil.all
  end

  # GET /spoils/1
  # GET /spoils/1.json
  def show
  end

  # GET /spoils/new
  def new
    @spoil = Spoil.new
  end

  def avatar
    @spoil = Spoil.includes(:player).find_by(game_id: cookies["current_game_id"], plate_id: params[:plate_id] )
    render plain: @spoil.nil? ? "" : @spoil.player.image
  end

  # POST /spoils
  # POST /spoils.json

  def lock
    @plate = Plate.find_by_code(params[:code])
    ActionCable.server.broadcast "game_channel_#{cookies["current_game_id"]}",
      state: params[:code],
      action: "lock",
      player: @active_player
    render plain: "true"
  end

  def unlock
    ActionCable.server.broadcast "game_channel_#{cookies["current_game_id"]}",
      state: params[:code],
      action: "unlock"
    render plain: "true"
  end

  def create
    @spoil = Spoil.new()
      @spoil.game_id = cookies["current_game_id"]
      @spoil.player_id = get_player_id

    @plate = Plate.find_by_code(params[:code])

    if @current_game.bonuses.map(&:plate_id).include?(@plate.id)
      bonus = true
      bonus_multiplier = 2
    else
      bonus = false
      bonus_multiplier = 1
    end

    @spoil.plate_id = @plate.id
    @spoil.current_coord = params[:current_location]

    distance=LocationService.distance(params[:current_location],@plate.geocode)

    @spoil.points= ( distance.gsub(',','').to_i / 100 ) * bonus_multiplier

    if bonus
      message = "BONUS points!!!  #{@spoil.player.first_name} found the plate for  #{@plate.state} for #{@spoil.points} points."
    else
      message = "#{@spoil.player.first_name} found the plate for  #{@plate.state} for #{@spoil.points} points."
    end

    respond_to do |format|
      if @spoil.save
          if @current_game.combatitive?
            points = GameService.points(@current_game, @spoil.player)
          else
            points = GameService.points(@current_game)
          end

          Timeline.create!(game: @current_game, message: message)

          # Rails server sends message to WS that will then be syndicated to all listening clients
          # action cable takes to attrs - the channel to send the message to (indentified by game id) and a hash of things
          # Each of these attrs (message, state, points... ) will be keys to a javascript hash
          ActionCable.server.broadcast "game_channel_#{cookies["current_game_id"]}",
            message: message,
            state: params[:code],
            player_name: @spoil.player.first_name,
            player: @spoil.player,
            points: points,
            bonus: bonus,
            action: "spoil"

        format.html { redirect_to @spoil, notice: 'Spoil was successfully created.' }
        format.json { render :show, status: :created, location: @spoil }
      else
        format.html { render :new }
        format.json { render json: @spoil.errors, status: :unprocessable_entity }
      end
    end
  end

  def clear
    @plate = Plate.find_by(code:params[:code])
    if @current_game.allow_player_switching?
      @spoil = Spoil.find_by(game_id: cookies["current_game_id"], plate_id: @plate.id )
    else
      @spoil = @active_player.spoils.find_by(game_id: cookies["current_game_id"], plate_id: @plate.id )
    end

    if @spoil
      @spoil.destroy
      if @current_game.combatitive?
        points = GameService.points(@current_game, @spoil.player)
      else
        points = GameService.points(@current_game)
      end

      message = "Apparently #{@spoil.player.first_name} didn't spoil the plate for  #{@plate.state}"

      Timeline.create!(game: @current_game, message: message)

      # Rails server sends message to WS that will then be syndicated to all listening clients
      ActionCable.server.broadcast "game_channel_#{cookies["current_game_id"]}",
      message: message,
      state: params[:code],
      points: points,
      player_name: @spoil.player.first_name,
      player: @spoil.player,
      action: "clear"

      respond_to do |format|
        format.html { redirect_to spoils_url, notice: 'Spoil was successfully cleared.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { render :none }
        format.json { render json: nil, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /spoils/1
  # DELETE /spoils/1.json
  def destroy
    @spoil.destroy
    respond_to do |format|
      format.html { redirect_to spoils_url, notice: 'Spoil was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_spoil
      @spoil = Spoil.find(params[:id])
    end

    def get_player_id
      return session[:player_id] unless @current_game.allow_player_switching
      return params[:player_id] || session[:player_id]
    end

    def set_current_game
      @current_game = Game.find(cookies[:current_game_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def spoil_params
      params.require(:spoil).permit(:plate_id)
    end

end
