class PlayChannel < ApplicationCable::Channel
  def subscribed
      stream_from 'play'
    end
end
