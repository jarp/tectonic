require 'rails_helper'

RSpec.describe Game, :type => :model do

  before(:each) do
    @game_type = GameType.create!(name: 'Combative')
    @game = FactoryGirl.build(:game, game_type: @game_type)
  end

  it 'should be a game' do
    expect(@game).to be_kind_of Game
  end
end
