class GamePlayer < ApplicationRecord
  belongs_to :game
  belongs_to :player
  before_create :create_token

  scope :active, -> { where(accepted: true) }
  scope :pending, -> { where( 'accepted <> true')}

  delegate :email, :first_name, :last_name, to: :player
  delegate :is_completed, :title,  to: :game

  def create_token
    self.token = SecureRandom.hex(4)
  end
end
