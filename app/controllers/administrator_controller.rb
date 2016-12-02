class AdministratorController < ApplicationController
  before_action :require_login
  before_action :set_active_player

  def set_active_player
    @active_player = active_player
  end


  def index
    @players = Player.all.includes(:spoils).sort_by { |p| p.spoils.sum('finds.points') }.reverse
    @games = Game.all.includes(:spoils)  .sort_by { | g | g.spoils.sum('finds.points') }.reverse
    @plates = Plate.all.includes(:spoils).sort_by { |p| p.spoils.sum('finds.points') }.reverse
  end
end
