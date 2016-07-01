class CreatePlates < ActiveRecord::Migration[5.0]
  def change
    create_table :plates do |t|
      t.string :state
      t.string :geocode

      t.timestamps
    end
  end
end
