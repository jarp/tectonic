class Plate < ApplicationRecord
  has_many :finds
  default_scope { order(:state) }
  def to_s
    state
  end
end
