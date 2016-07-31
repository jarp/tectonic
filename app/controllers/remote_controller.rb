class RemoteController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def active_player
    return @active_player || @active_player = Player.find_by(api_key: params[:api_key]) if params[:api_key]
  end

  def require_system_access
    puts "does #{params[:system_api_key]} == #{ENV['TECTONIC_SYSTEM_API_KEY']}"
    render text: 'No', status: 401 unless params[:system_api_key] == ENV['TECTONIC_SYSTEM_API_KEY']
  end

end
