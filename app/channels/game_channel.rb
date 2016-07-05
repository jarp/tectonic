class GameChannel < ApplicationCable::Channel
  def subscribed
      stream_from "game_channel-#{cookies["current_game_id"]}"
    end
end
