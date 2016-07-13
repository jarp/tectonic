class AddBonusCountToGames < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :bonus_count, :integer
  end
end
