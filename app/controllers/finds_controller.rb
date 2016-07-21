require 'net/http'
require 'openssl'

class FindsController < ActivePlayerController
  before_action :set_find, only: [:show, :edit, :update, :destroy]
  before_action :set_current_game, only: [:create, :clear]

  # GET /finds
  # GET /finds.json
  def index
    @finds = Find.all
  end

  # GET /finds/1
  # GET /finds/1.json
  def show
  end

  # GET /finds/new
  def new
    @find = Find.new
  end

  # GET /finds/1/edit
  def edit
  end

  def avatar
    @find = Find.includes(:player).find_by(game_id: cookies["current_game_id"], plate_id: params[:plate_id] )
    render plain: @find.nil? ? "" : @find.player.image
  end

  # POST /finds
  # POST /finds.json

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
    render text: "true"
  end

  def create

    @find = Find.new()
      @find.game_id = cookies["current_game_id"]
      @find.player_id = get_player_id

    @plate = Plate.find_by_code(params[:code])

    if @current_game.bonuses.map(&:plate_id).include?(@plate.id)
      bonus = true
      bonus_multiplier = 2
    else
      bonus = false
      bonus_multiplier = 1
    end

    @find.plate_id = @plate.id
    @find.current_coord = params[:current_location]

    distance=LocationService.distance(params[:current_location],@plate.geocode)

    @find.points= ( distance.gsub(',','').to_i / 100 ) * bonus_multiplier

    if bonus
      message = "BONUS points!!!  #{@find.player.first_name} found the plate for  #{@plate.state} for #{@find.points} points."
    else
      message = "#{@find.player.first_name} found the plate for  #{@plate.state} for #{@find.points} points."
    end

    respond_to do |format|
      if @find.save
          if @current_game.combatitive?
            points = GameService.points(@current_game, @find.player)
          else
            points = GameService.points(@current_game)
          end
          Timeline.create!(game: @current_game, message: message)
          ActionCable.server.broadcast "game_channel_#{cookies["current_game_id"]}",
            message: message,
            state: params[:code],
            player_name: @find.player.first_name,
            player: @find.player,
            points: points,
            bonus: bonus,
            action: "find"
        format.html { redirect_to @find, notice: 'Find was successfully created.' }
        format.json { render :show, status: :created, location: @find }
      else
        format.html { render :new }
        format.json { render json: @find.errors, status: :unprocessable_entity }
      end
    end
  end

  def clear
    @plate = Plate.find_by(code:params[:code])
    if @current_game.allow_player_switching?
      @find = Find.find_by(game_id: cookies["current_game_id"], plate_id: @plate.id )
    else
      @find = @active_player.finds.find_by(game_id: cookies["current_game_id"], plate_id: @plate.id )
    end

    if @find
      @find.destroy
      if @current_game.combatitive?
        points = GameService.points(@current_game, @find.player)
      else
        points = GameService.points(@current_game)
      end

      message = "Apparently #{@find.player.first_name} didn't find the plate for  #{@plate.state}"

      Timeline.create!(game: @current_game, message: message)
      ActionCable.server.broadcast "game_channel_#{cookies["current_game_id"]}",
      message: message,
      state: params[:code],
      points: points,
      player_name: @find.player.first_name,
      player: @find.player,
      action: "clear"



      respond_to do |format|
        format.html { redirect_to finds_url, notice: 'Find was successfully cleared.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { render :none }
        format.json { render json: nil, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /finds/1
  # DELETE /finds/1.json
  def destroy
    @find.destroy
    respond_to do |format|
      format.html { redirect_to finds_url, notice: 'Find was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_find
      @find = Find.find(params[:id])
    end

    def get_player_id
      return session[:player_id] unless @current_game.allow_player_switching
      return params[:player_id] || session[:player_id]
    end

    def set_current_game
      @current_game = Game.find(cookies[:current_game_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def find_params
      params.require(:find).permit(:plate_id)
    end

end
