class Tour < ActiveRecord::Base
  belongs_to :player
  belongs_to :owner, class_name: "Player", foreign_key: "player_id"

  has_many :games
  has_many :spoils, through: :games

  has_many :players, through: :games

  def unique_spoils
    all_spoils = spoils.order(:created_at)
    unique_spoils = []
    all_spoils.each { | f | unique_spoils << f unless unique_spoils.map(&:plate).include?(f.plate) }
    return unique_spoils
  end

  def to_s
    name
  end
end
