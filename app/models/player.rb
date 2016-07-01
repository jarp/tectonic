class Player < ApplicationRecord
  has_many :game_players
  has_many :games, through: :game_players
  has_many :finds
  def super?
    is_super ? true : false
  end

  def to_s
    return "#{first_name} #{last_name}" unless first_name.blank?
    return email
  end
end
