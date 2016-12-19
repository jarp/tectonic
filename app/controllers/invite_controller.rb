class InviteController < ActivePlayerController
  def index
  end

  def create
    @game = @active_player.games.find(params[:invite][:game_id])
    @player = Player.where(email: params[:invite][:email]).first_or_create
    puts "create a game player :: #{@game.players.count}"
    raise "Player limit has been reached. Sorry." if @game.players.count > 3
    @game_player = GameService.add_player(@game, @player)
    @game_player.update(accepted: false)

    if @game_player
      puts "send invite"
      send_invite
    else
      puts  "not new"
    end

    respond_to do |format|
      if @game_player
          format.html { redirect_to @game_player, notice: 'Invitation was successfully created.' }
          format.json { render json: @game_player, status: :created }
      else
        format.html { render :new }
        format.json { render json: @game_player.errors, status: :unprocessable_entity }
      end
    end
  end

  def accept
    gp = GamePlayer.find_by_token(params[:token])
    gp.update(accepted: true)
    redirect_to play_game_path(gp.game)
  end

  private

  def send_invite
    NotifierMailer.invite(@game_player.player, @game_player.token).deliver_now
    puts "should send invite to #{params[:email]} with invite code of #{@game_player.token}"
  end

end
