require 'rails_helper'
require 'support/shared_contexts/sessions'
require 'support/shared_contexts/current_game'

RSpec.describe GamesController, :type => :controller do
  include_context "sessions"
  include_context "current_game"

  before(:each) do
    login_as(@player)
    Game.destroy_all
  end

  describe "GET index" do
    it "assigns all invistations that are active games as @games" do
      game = FactoryGirl.create(:game, player_id: @player.id)
      GameService.add_player(game, @player, false, true)
      get :index
      puts assigns(:games).inspect
      puts game.inspect
      expect(assigns(:games).map(&:game)).to eq [game]
    end
  end

  describe "GET show" do
    it "assigns the requested game as @game" do
      game = FactoryGirl.create(:game, player_id: @player.id)
      get :show, {:id => game.to_param}, valid_session
      expect(assigns(:game)).to eq (game)
    end
  end

  describe "GET new" do
    it "assigns a new game as @game" do
      get :new, {}, valid_session
      expect(assigns(:game)).to be_a_new(Game)
    end
  end

  describe "GET edit" do
    it "assigns the requested game as @game" do
      game = FactoryGirl.create(:game, player_id: @player.id)
      get :edit, {:id => game.to_param}, valid_session
      expect(assigns(:game)).to eq(game)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Game" do
        expect {
          post :create, {:game => valid_attributes}, valid_session
        }.to change(Game, :count).by(1)
      end

      it "assigns a newly created game as @game" do
        post :create, {:game => valid_attributes}, valid_session
        expect(assigns(:game)).to be_a(Game)
        expect(assigns(:game)).to be_persisted
      end

      it "redirects to the created game" do
        post :create, {:game => valid_attributes}, valid_session
        expect(response).to redirect_to(Game.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved game as @game" do
        post :create, {:game => invalid_attributes}, valid_session
        expect(assigns(:game)).to be_a_new(Game)
      end

      it "re-renders the 'new' template" do
        post :create, {:game => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested game" do
        game = FactoryGirl.create(:game, player_id: @player.id)
        put :update, {:id => game.to_param, :game => new_attributes}, valid_session
        game.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested game as @game" do
        game = FactoryGirl.create(:game, player_id: @player.id)
        put :update, {:id => game.to_param, :game => valid_attributes}, valid_session
        expect(assigns(:game)).to eq(game)
      end

      it "redirects to the game" do
        game = FactoryGirl.create(:game, player_id: @player.id)
        put :update, {:id => game.to_param, :game => valid_attributes}, valid_session
        expect(response).to redirect_to(game)
      end
    end

    describe "with invalid params" do
      it "assigns the game as @game" do
        game = FactoryGirl.create(:game, player_id: @player.id)
        put :update, {:id => game.to_param, :game => invalid_attributes}, valid_session
        expect(assigns(:game)).to eq(game)
      end

      it "re-renders the 'edit' template" do
        game = FactoryGirl.create(:game, player_id: @player.id)
        put :update, {:id => game.to_param, :game => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested game" do
      game = FactoryGirl.create(:game, player_id: @player.id)
      expect {
        delete :destroy, {:id => game.to_param}, valid_session
      }.to change(Game, :count).by(-1)
    end

    it "redirects to the games list" do
      game = FactoryGirl.create(:game, player_id: @player.id)
      delete :destroy, {:id => game.to_param}, valid_session
      expect(response).to redirect_to(games_url)
    end
  end

end
