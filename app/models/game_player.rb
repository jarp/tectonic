class GamePlayer < ActiveRecord::Base
  belongs_to :game
  belongs_to :player
  before_create :create_token

  validates :game, :player, presence: true
  validates :player, uniqueness: { scope: :game_id }

  scope :active, -> { where(accepted: true) }
  scope :pending, -> { where(accepted: false) }

  delegate :email, :first_name, :last_name, to: :player
  delegate :is_completed, :title,  to: :game

  def create_token
    self.token = SecureRandom.hex(4)
  end
end
