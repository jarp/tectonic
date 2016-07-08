class AddUseImagesToGames < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :use_images, :boolean
  end
end
