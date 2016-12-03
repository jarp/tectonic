class AddImageToBonus < ActiveRecord::Migration[5.0]
  def change
    add_column :bonus, :image, :string
  end
end
