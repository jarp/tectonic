require 'net/http'
require 'openssl'

class FindsController < ActivePlayerController
  before_action :set_find, only: [:show, :edit, :update, :destroy]
  before_action :set_game, only: [:create, :clear]

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
    @plate = Plate.find_by(code:params[:code])
    @find = Find.find_by(game_id: cookies["current_game_id"], plate_id: @plate.id ) # if @active_player.finds.any?
    render plain: @find.nil? ? "" : @find.player.image
  end

  # POST /finds
  # POST /finds.json

  def lock
    # raise 'kanye says no'
    @plate = Plate.find_by_code(params[:code])
    ActionCable.server.broadcast "game_channel_#{cookies["current_game_id"]}",
    #message: "#{@active_player.first_name} found the plate for  #{@plate.state}",
    state: params[:code],
    action: "lock"

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
    @find.player_id = session[:player_id]
    @plate = Plate.find_by_code(params[:code])
    @find.plate_id = @plate.id
    @find.current_coord = params[:current_location]
    state_coords = get_target_coordinates(@plate.state)
    @find.state_coord = "#{state_coords["lat"]}|#{state_coords["lng"]}"
    distance=get_distance(params[:current_location],@plate.state)
    @find.points=distance.gsub(',','').to_i / 100

    respond_to do |format|
      if @find.save

          points = GameService.points(@game, @active_player)
          ActionCable.server.broadcast "game_channel_#{cookies["current_game_id"]}",
          message: "#{@active_player.first_name} found the plate for  #{@plate.state} for #{@find.points} points.",
          state: params[:code],
          player_name: @active_player.first_name,
          player: @active_player,
          points: points,
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
    @find = @active_player.finds.find_by(game_id: cookies["current_game_id"], plate_id: @plate.id ) # if @active_player.finds.any?

    if @find
      @find.destroy
      points = GameService.points(@game, @active_player)
      ActionCable.server.broadcast "game_channel_#{cookies["current_game_id"]}",
      message: "Apparently #{@active_player.first_name} didn't find the plate for  #{@plate.state}",
      state: params[:code],
      points: points,
      player_name: @active_player.first_name,
      player: @active_player,
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

    def set_game
      @game = Game.find(cookies[:current_game_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def find_params
      params.require(:find).permit(:plate_id)
    end

    def get_distance(origin, state)
      endpoint = "https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=#{origin.gsub('|',',')}&destinations=State of #{state}&key=#{ENV['TECTONIC_API']}"
      puts "endpoint is: #{endpoint}"
      uri = URI(endpoint)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE # You should use VERIFY_PEER in production
      request = Net::HTTP::Get.new(uri.request_uri)
      res = http.request(request)
      puts "found distance matrix: #{JSON.parse(res.body)}"
      return JSON.parse(res.body)["rows"][0]["elements"][0]["distance"]["text"]
    end

    def get_target_coordinates(state)
      puts  "fetching target location from google"
      uri = URI("http://maps.googleapis.com/maps/api/geocode/json?address=#{state}")
      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Get.new(uri.request_uri)
      res = http.request(request)
      return JSON.parse(res.body)["results"][0]["geometry"]["location"]
    end

end
