# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :game_id

    def connect
      self.game_id = cookies[:current_game_id]
    end
  end
end
