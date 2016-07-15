class AdministratorController < ApplicationController
  before_action :require_login
  before_action :set_active_player

  def set_active_player
    @active_player = active_player
  end


  def index
    @players = Player.all.includes(:finds).sort_by { |p| p.finds.sum('finds.points') }.reverse
    @games = Game.all.includes(:finds)  .sort_by { | g | g.finds.sum('finds.points') }.reverse
    @plates = Plate.all.includes(:finds).sort_by { |p| p.finds.sum('finds.points') }.reverse
  end
end
