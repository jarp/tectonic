class AddCurrentLocationAndOoordsToSpoils < ActiveRecord::Migration[5.0]
  def change
    add_column :spoils, :current_coord, :string
    add_column :spoils, :state_coord, :string
  end
end
