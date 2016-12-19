class GamePlayersController < ActivePlayerController
  before_action :set_game_player, only: [:show, :edit, :update, :destroy]
  layout 'raw'
  # GET /game_players
  # GET /game_players.json
  def index
    @game_players = params[:game_id] ? GamePlayer.where(game_id: params[:game_id]) : @game_players = GamePlayer.all
  end

  def count
    set_game
    render text: @game.players.count
  end
  # GET /game_players/1
  # GET /game_players/1.json
  def show
  end

  # GET /game_players/new
  def new
    @game_player = GamePlayer.new
  end

  # GET /game_players/1/edit
  def edit
  end

  # POST /game_players
  # POST /game_players.json
  def create
    set_game
    puts "create a game player :: #{@game.players.count}"
    raise "Player limit has been reached. Sorry." if @game.players.count > 3
    @game_player = GamePlayer.new(game_player_params)
    system 'clear'
    puts "create invite iwth #{params}"
    respond_to do |format|
      if @game_player.save
        format.html {puts "proccessed as html";  redirect_to @game_player, notice: 'Game player was successfully created.' }
        format.json {puts "proccessed as json"; render json: @game_player, status: :created }
        format.js {puts "proccessed as json"; render json: @game_player, status: :created }
      else
        format.html { render :new }
        format.json { render json: @game_player.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /game_players/1
  # DELETE /game_players/1.json
  def destroy
    puts "params for destroy #{params.inspect}"
    @game_player.destroy
    respond_to do |format|
      format.html { redirect_to game_players_url, notice: 'Game player was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game_player
      @game_player = GamePlayer.find(params[:id])
    end

    def set_game
      @game = Game.find(params[:game_id]) if params[:game_id]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_player_params
      params.require(:game_player).permit(:game_id, :player_id, :accepted)
    end
end
