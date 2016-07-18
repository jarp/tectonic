class Tour < ApplicationRecord
  belongs_to :player
  belongs_to :owner, class_name: "Player", foreign_key: "player_id"

  has_many :games
  has_many :finds, through: :games

  def unique_finds
    all_finds = finds.order(:created_at)
    unique_finds = []
    all_finds.each { | f | unique_finds << f unless unique_finds.map(&:plate).include?(f.plate) }
    return unique_finds
  end
end
