# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class GameChannel < ApplicationCable::Channel
  def subscribed
    puts "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n#{@active_player} :: Subscribed from channel\n%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
    stream_from "game_channel_#{game_id}"
  end

  def unsubscribed
    puts "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n#{@active_player} :: UNnsubscribed from channel\n%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
  end
end
