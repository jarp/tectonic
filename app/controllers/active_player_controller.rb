class ActivePlayerController < ApplicationController
  before_action :require_login
  before_action :set_active_player

  def set_active_player
    @active_player = active_player
  end

end
