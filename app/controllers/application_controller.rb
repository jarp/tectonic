class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # skip_before_filter :verify_authenticity_token if contains_api_key?
  # protect_from_forgery with: :exception

  def active_player
      puts "get active player"
      puts " token >> #{request.headers["tectonic-auth-token"]}"
      return @active_player || @active_player = Player.find_by(api_key: params[:api_key]) if params[:api_key]
      return @active_player || @active_player = Player.find(session[:player_id]) if session[:player_id]

  end

  def contains_api_key?
    params.fetch(:api_key, nil) ? true : false
  end

  def require_login
    puts "require login"
    cookies[:return_to] = request.fullpath if request.fullpath.include?('invite') || request.fullpath.include?('play')
    redirect_to login_path unless session[:player_id] || params[:api_key]
  end

  def require_super_player_login
    redirect_to login_path unless active_player.super?
  end

  def show_404
    render text: File.read(Rails.root.join('public/404.html')), status: 404
  end


end
