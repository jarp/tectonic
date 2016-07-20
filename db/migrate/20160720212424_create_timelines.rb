class CreateTimelines < ActiveRecord::Migration[5.0]
  def change
    create_table :timelines do |t|
      t.references :game, foreign_key: true
      t.references :player, foreign_key: true
      t.references :plate, foreign_key: true
      t.text :message

      t.timestamps
    end
  end
end
