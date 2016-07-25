
class Player < ApplicationRecord
  has_many :game_players, dependent: :destroy
  has_many :games, through: :game_players
  has_many :owned_games, class_name: "Game"
  has_many :finds, dependent: :destroy

  has_many :invitations, class_name: 'GamePlayer', foreign_key: 'player_id', dependent: :destroy
  has_many :tours, dependent: :destroy
  validates :email, uniqueness: true

  before_save :create_api_key

  def super?
    is_super ? true : false
  end

  def avatar
    return image if image
    return "/assets/missing_avatar.jpg"
  end

  def to_s
    return "#{first_name} #{last_name}" unless first_name.blank?
    return email
  end

  def create_api_key
    if self.api_key.blank?
      self.api_key = SecureRandom.hex(16)
    end
  end
end
