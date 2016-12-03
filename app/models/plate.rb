class Plate < ActiveRecord::Base
  has_many :spoils
  default_scope { order(:state) }
  def to_s
    state
  end
end
