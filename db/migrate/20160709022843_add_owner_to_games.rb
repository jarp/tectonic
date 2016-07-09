class AddOwnerToGames < ActiveRecord::Migration[5.0]
  def change
    add_reference :games, :player, foreign_key: true
  end
end
