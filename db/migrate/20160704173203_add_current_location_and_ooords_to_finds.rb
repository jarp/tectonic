class AddCurrentLocationAndOoordsToFinds < ActiveRecord::Migration[5.0]
  def change
    add_column :finds, :current_coord, :string
    add_column :finds, :state_coord, :string
  end
end
