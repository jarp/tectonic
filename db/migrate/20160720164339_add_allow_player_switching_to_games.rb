class AddAllowPlayerSwitchingToGames < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :allow_player_switching, :boolean
  end
end
