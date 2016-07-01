class Game < ApplicationRecord
  belongs_to :game_type
  has_many :game_players, dependent: :destroy
  has_many :players, through: :game_players
  has_many :finds, dependent: :destroy
  has_many :plates, through: :finds

  before_create :create_token

  def to_s
    "#{game_type} #{title}"
  end

  def create_token
    self.token = SecureRandom.hex(4)
  end

  def active_players
    game_players.active
  end
end
