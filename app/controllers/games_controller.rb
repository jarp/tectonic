class GamesController < ActivePlayerController
  before_action :set_game, only: [:show, :edit, :complete, :results, :update, :destroy]

  # GET /games
  # GET /games.json
  def index
    @games = @active_player.invitations.active
    @invitations = @active_player.invitations.pending
    @completed_games = @active_player.games.completed
  end

  # GET /games/1
  # GET /games/1.json
  def show
  end

  def results
    @leaders = @leaders = Table.new(@game).leaders
  end

  # GET /games/new
  def new
    @game = Game.new
  end

  # GET /games/1/edit
  def edit
  end

  # POST /games
  # POST /games.json
  def create
    @game = Game.new(game_params)
    @game.owner = @active_player

    respond_to do |format|
      if @game.save
        gp = GameService.add_player(@game, @active_player, true)
        gp.update(accepted: true)
        format.html { redirect_to @game, notice: 'Game was successfully created.' }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /games/1
  # PATCH/PUT /games/1.json
  def update
    respond_to do |format|
      if @game.update(game_params)
        format.html { redirect_to @game, notice: 'Game was successfully updated.' }
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :edit }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end


def complete
  if @game
    @game.complete!
    flash[:message] = 'Game was successfully completed'
  else
    flash[:message] = "You can't do that!"
  end
    redirect_to games_url
end
  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game.destroy
    respond_to do |format|
      format.html { redirect_to games_url, notice: 'Game was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = @active_player.games.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_params
      params.require(:game).permit(:title, :game_type_id, :use_images)
    end
end
