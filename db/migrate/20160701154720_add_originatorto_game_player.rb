class AddOriginatortoGamePlayer < ActiveRecord::Migration[5.0]
  def change
    add_column :game_players, :originator, :boolean, default: false
  end
end
