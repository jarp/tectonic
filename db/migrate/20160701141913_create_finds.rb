class CreateFinds < ActiveRecord::Migration[5.0]
  def change
    create_table :finds do |t|
      t.references :game, foreign_key: true
      t.references :player, foreign_key: true
      t.references :plate, foreign_key: true
      t.integer :points

      t.timestamps
    end
  end
end
