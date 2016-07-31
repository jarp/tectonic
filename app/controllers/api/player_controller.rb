class Api::PlayerController < RemoteController
  before_action :require_system_access

  def lookup
    @player = Player.where(email: params[:email].downcase).first_or_create
    render text: "{value: #{@player.api_key}}"
  end

end
