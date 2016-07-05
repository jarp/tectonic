class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def active_player
    if session[:player_id]
      @active_player || @active_player = Player.find(session[:player_id])
    end
  end

  def require_login
    cookies[:return_to] = request.fullpath unless request.fullpath == '/logout'
    redirect_to login_path unless session[:player_id]
  end

  def require_super_player_login
    redirect_to login_path unless active_player.super?
  end

  def show_404
    render text: File.read(Rails.root.join('public/404.html')), status: 404
  end
end
