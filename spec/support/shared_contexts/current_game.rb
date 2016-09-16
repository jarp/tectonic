RSpec.shared_context "current_game" do

  before(:each) do
    @other_player = FactoryGirl.create(:player, first_name: 'Erron', last_name: 'McFail', email: "test2-#{SecureRandom.hex(5)}@test.com")
    @current_game = FactoryGirl.create(:game, game_type_id: GameType.first.id)
    GameService.add_player(@current_game, @player, true, true)
    GameService.add_player(@current_game, @other_player, false, true)
    @current_game.owner = @player
    @current_game.game_type_id = GameType.first.id
  end

  after(:each) do
    @other_player.destroy
  end

end
