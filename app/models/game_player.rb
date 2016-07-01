class GamePlayer < ApplicationRecord
  belongs_to :game
  belongs_to :player
  before_create :create_token

  scope :active, -> { where(accepted: true) }
  
  def create_token
    self.token = SecureRandom.hex(4)
  end
end
