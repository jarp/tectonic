class InviteController < ActivePlayerController
  def index
  end

  def create
    @game = @active_player.games.find(params[:invite][:game_id])
    @player = Player.where(email: params[:invite][:email]).first_or_create
    @game_player = GameService.add_player(@game, @player)
    send_invite

    respond_to do |format|
      if @game_player
        format.html { redirect_to @game, notice: 'Invitation was successfully created.' }
        format.json { render :show, status: :created, location: @game_player }
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
