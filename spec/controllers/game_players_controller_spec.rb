require 'rails_helper'
require 'support/shared_contexts/sessions'
require 'support/shared_contexts/current_game'

RSpec.describe GamePlayersController, :type => :controller do
  include_context "sessions"

  before(:each) do
    login_as(@player)
  end

  let(:valid_attributes){
    {player_id: @player.id, game_id: Game.first.id }
  }
  describe "GET index" do
    it "assigns all game_players as @game_players" do
      game_player = FactoryGirl.create(:game_player)
      get :index, {}, valid_session
      expect(assigns(:game_players)).to eq([game_player])
    end

    it "assigns a filtere list of game_players as @game_players" do
      game_player = FactoryGirl.create(:game_player)
      other_game = FactoryGirl.create(:game)
      other_game_player = FactoryGirl.create(:game_player, player: @player, game: other_game)
      get :index, {game_id: other_game.id}, valid_session
      expect(assigns(:game_players)).to eq([other_game_player])
    end

  end

  describe "GET show" do
    it "assigns the requested game_player as @game_player" do
      game_player = FactoryGirl.create(:game_player)
      get :show, {:id => game_player.to_param}, valid_session
      expect(assigns(:game_player)).to eq(game_player)
    end
  end

  describe "GET new" do
    it "assigns a new game_player as @game_player" do
      get :new, {}, valid_session
      expect(assigns(:game_player)).to be_a_new(GamePlayer)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new GamePlayer" do
        puts ">>>> #{valid_attributes.inspect}"
        expect {
          post :create, {:game_player => valid_attributes}, valid_session
        }.to change(GamePlayer, :count).by(1)
      end

      it "assigns a newly created game_player as @game_player" do
        post :create, {:game_player => valid_attributes}, valid_session
        expect(assigns(:game_player)).to be_a(GamePlayer)
        expect(assigns(:game_player)).to be_persisted
      end

      it "redirects to the created game_player" do
        post :create, {:game_player => valid_attributes}, valid_session
        expect(response).to redirect_to(GamePlayer.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved game_player as @game_player" do
        post :create, {:game_player => {player_id: 42}}, valid_session
        expect(assigns(:game_player)).to be_a_new(GamePlayer)
      end

      it "re-renders the 'new' template" do
        post :create, {:game_player => {player_id: 42}}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested game_player" do
      game_player = FactoryGirl.create(:game_player)
      expect {
        delete :destroy, {:id => game_player.to_param}, valid_session
      }.to change(GamePlayer, :count).by(-1)
    end

    it "redirects to the game_players list" do
      game_player = FactoryGirl.create(:game_player)
      delete :destroy, {:id => game_player.to_param}, valid_session
      expect(response).to redirect_to(game_players_url)
    end
  end

end
