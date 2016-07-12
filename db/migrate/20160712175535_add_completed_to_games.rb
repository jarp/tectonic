class AddCompletedToGames < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :is_completed, :boolean, default: false
    add_column :games, :completed_at, :datetime
  end
end
