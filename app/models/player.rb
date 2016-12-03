class Player < ActiveRecord::Base
  has_many :game_players, dependent: :destroy
  has_many :games, through: :game_players
  has_many :owned_games, class_name: "Game"
  has_many :spoils, dependent: :destroy

  has_many :invitations, class_name: 'GamePlayer', foreign_key: 'player_id', dependent: :destroy
  has_many :tours, dependent: :destroy
  validates :email, uniqueness: true


  def super?
    is_super ? true : false
  end

  def avatar
    return image if image
    return "/ing/missing_avatar.jpg"
  end

  def to_s
    return "#{first_name} #{last_name}" unless first_name.blank?
    return email
  end
end
