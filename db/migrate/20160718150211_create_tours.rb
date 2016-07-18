class CreateTours < ActiveRecord::Migration[5.0]
  def change
    create_table :tours do |t|
      t.string :name
      t.date :start_on
      t.date :end_on
      t.references :player, foreign_key: true

      t.timestamps
    end
  end
end
