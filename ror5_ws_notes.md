# Tectonic Notes Concerning Web Sockets and ActionCable

## Requirements

Rails 5
Redis Server

## Config

cable.yml file controlls redis adapter and endpoint

## New Classes

2 New Classes in app/channels
channels/
  application_cable/
    channel.rb
    connection.rb
  game_channel.rb

## New Javascript Files
2 new JS files

cable.js
channels/
  game.js (This is the file that responds to messages.)

## New Route
Mount WS Server as a route

## Using ActionCable in Controllers
Rails Controllers

  spoils#create
    sends what plate was found, who found it, the points it's worth, and a message
  spoils#clear
    sends what plate was not found, who didn't spoil it, the points it's worth, and a message


cd /apps/tectonic/current && ( export RACK_ENV="production" ; ~/.rvm/bin/rvm ruby-2.2.4 do bundle exec puma -C /apps/tectonic/shared/puma.rb --daemon )
