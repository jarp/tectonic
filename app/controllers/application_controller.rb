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
    cookies[:return_to] = request.fullpath if request.fullpath.include?('invite') || request.fullpath.include?('play')
    redirect_to login_path unless session[:player_id]
  end

  def require_super_player_login
    redirect_to login_path unless active_player.super?
  end

  def show_404
    render text: File.read(Rails.root.join('public/404.html')), status: 404
  end

  def letsencrypt
    render text: "XyzBBPZ5jxO-u6Nw9KrheM3SHuqMKQXsQ13XXl1vP94.XUyJ9oW_LVu5HKzY4G2w2sx3dsOI73mXDxLZ6_Ymk1Q"
  end
end
