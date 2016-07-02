class FindsController < ActivePlayerController
  before_action :set_find, only: [:show, :edit, :update, :destroy]

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
    render text: @find.player.image
  end

  # POST /finds
  # POST /finds.json
  def create
    @find = Find.new()
    @find.game_id = cookies["current_game_id"]
    @find.player_id = session[:player_id]
    @plate = Plate.find_by_code(params[:code])
    @find.plate_id = @plate.id

    respond_to do |format|
      if @find.save

          ActionCable.server.broadcast 'play',
          message: "#{@active_player.first_name} found the plate for  #{@plate.state}",
          state: params[:code],
          player_name: @active_player.first_name,
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

      ActionCable.server.broadcast 'play',
      message: "Apparently #{@active_player.first_name} didn't find the plate for  #{@plate.state}",
      state: params[:code],
      player_name: @active_player.first_name,
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def find_params
      params.require(:find).permit(:plate_id)
    end
end
