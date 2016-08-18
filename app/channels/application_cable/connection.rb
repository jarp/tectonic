# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
module ApplicationCable
  class Connection < ActionCable::Connection::Base
    # want to have a channel for each game running so create an idenifier
    identified_by :game_id

    def connect
      # when a user connects to a ws channel, use the users cookie to set the identifier
      self.game_id = cookies[:current_game_id]
    end
  end
end
