class AdministratorController < ApplicationController
  before_action :require_login
  before_action :set_active_player

  def set_active_player
    @active_player = active_player
  end


  def index
    @players = Player.all.includes(:spoils).sort_by { |p| p.spoils.sum('spoils.points') }.reverse
    @games = Game.all.includes(:spoils)  .sort_by { | g | g.spoils.sum('spoils.points') }.reverse
    @plates = Plate.all.includes(:spoils).sort_by { |p| p.spoils.sum('spoils.points') }.reverse
  end
end
