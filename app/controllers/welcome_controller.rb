class WelcomeController < ApplicationController

  before_action :active_player
  def index
  end

  def about
  end

  def map
    @plates = Plate.includes(:spoils).all
  end
end
