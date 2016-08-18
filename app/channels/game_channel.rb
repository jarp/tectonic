# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class GameChannel < ApplicationCable::Channel
  def subscribed
    puts "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n#{@active_player} :: Subscribed from channel\n%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
    # this creates a specific channel identified with the game id
    # when a client connects with will have a current_game_id cookie.that is used to specify the channel
    stream_from "game_channel_#{game_id}"
  end

  def unsubscribed
    puts "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n#{@active_player} :: UNnsubscribed from channel\n%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
  end
end
