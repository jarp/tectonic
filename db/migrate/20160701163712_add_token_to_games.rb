class AddTokenToGames < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :token, :string
  end
end
