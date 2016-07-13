class Bonus < ApplicationRecord
  belongs_to :game
  belongs_to :plate

  self.table_name = 'bonus'
end
