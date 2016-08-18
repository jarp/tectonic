class Game < ApplicationRecord
  belongs_to :game_type

  has_many :game_players, dependent: :destroy
  has_many :players, through: :game_players

  has_many :finds, dependent: :destroy
  has_many :plates, through: :finds

  belongs_to :owner, class_name: "Player", foreign_key: "player_id"
  has_many :bonuses, dependent: :destroy, class_name: 'Bonus'

  has_many :timelines, dependent: :destroy

  belongs_to :tour

  before_create :create_token

  scope :active,  -> { where(is_completed: false)}
  scope :completed, -> { where(is_completed: true).order(:completed_at)}

  def to_s
    "#{game_type} #{title}"
  end

  def part_of_tour?
    return tour ? true : false
  end

  def collaborative?
    return true if game_type_id == 1
  end

  def combatitive?
    return true if game_type_id == 2
  end

  def create_token
    self.token = SecureRandom.hex(4)
  end

  def active_players
    game_players.active
  end

  def complete!
    self.is_completed = true
    save
  end

  def total_points
    finds.sum(:points)
  end
end
