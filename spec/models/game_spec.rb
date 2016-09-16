require 'rails_helper'

RSpec.describe Game, :type => :model do

  before(:each) do
    @game_type = GameType.create!(name: 'Combative')
    @game = FactoryGirl.build(:game, game_type: @game_type)
  end

  describe 'tokens' do
    it 'creates a token on create' do
      game = FactoryGirl.build(:game)
      expect(game.token).to be_nil
      game.save
      game.reload
      expect(game.token).to_not be_nil
    end
  end

  describe 'methods' do
    it 'should return true if part of a tour' do

    end

    it 'should return false if not part of a tour' do

    end

  end


end
