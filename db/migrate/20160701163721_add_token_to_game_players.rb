class AddTokenToGamePlayers < ActiveRecord::Migration[5.0]
  def change
    add_column :game_players, :token, :string
  end
end
