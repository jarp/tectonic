class Timeline < ApplicationRecord
  belongs_to :game
  belongs_to :player
  belongs_to :plate
end
