class Plate < ApplicationRecord

  default_scope { order(:state) }
  def to_s
    state
  end
end
