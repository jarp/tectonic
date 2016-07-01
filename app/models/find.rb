class Find < ApplicationRecord
  belongs_to :game
  belongs_to :player
  belongs_to :plate

  validates :game, :player, :plate, presence: true
end
