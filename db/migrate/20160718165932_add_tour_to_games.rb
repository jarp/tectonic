class AddTourToGames < ActiveRecord::Migration[5.0]
  def change
    add_reference :games, :tour, foreign_key: true
  end
end
