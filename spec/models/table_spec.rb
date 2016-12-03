require 'rails_helper'

RSpec.describe Table, :type => :model do
  before(:each) do
    game = FactoryGirl.create(:game)
    @player_1 = FactoryGirl.create(:player, email: 'test1@test.com')
    @player_2 = FactoryGirl.create(:player, email: 'test2@test.com')
    GameService.add_player(game, @player_1)
    GameService.add_player(game, @player_2)

    FactoryGirl.create(:spoil, player: @player_2, game: game, plate: Plate.first)

    @table = Table.new(game)
  end

  it 'responds to leaders' do
    expect(@table).to respond_to 'leaders'
  end

  it 'returns and array of leaders' do
    expect(@table.leaders).to be_kind_of Array
    expect(@table.leaders.count).to  eq 2
  end

  it 'returns hashes with player, their finds, and total points' do
    expect(@table.leaders.first).to be_kind_of Hash
    leader = @table.leaders.first
    expect(leader[:player]).to be_kind_of Player
    expect(leader[:states]).to be_kind_of Array
    expect(leader[:total_points]).to be_kind_of Integer
  end

  it 'returns leaders in sorted by total points' do
    expect(@table.leaders.first[:player]).to eq @player_2
  end

end
