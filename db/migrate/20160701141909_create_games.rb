class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.string :title
      t.references :game_type, foreign_key: true

      t.timestamps
    end
  end
end
