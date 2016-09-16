require 'rails_helper'
require 'support/shared_contexts/sessions'
require 'support/shared_contexts/current_game'

RSpec.describe SpoilsController, :type => :controller do
  include_context "sessions"
  include_context "current_game"

  before(:each) do
    session[:player_id] = @player.id
    cookies[:current_game_id] = @current_game.id
  end

  describe "GET index" do


    it "should be successfull" do
      session[:player_id] = @player.id
      get :index, params: {}
      expect(response).to be_successful
    end


    it "assigns all spoils as @spoils" do
      spoil = FactoryGirl.create(:spoil, game: @current_game, player: @player)
      get :index, params: {}, session: valid_session
      expect(assigns(:spoils)).to eq([spoil])
    end
  end

  describe "GET show" do
    it "assigns the requested spoil as @spoil" do
      spoil = FactoryGirl.create(:spoil, game: @current_game, player: @player)
      get :show, params: {:id => spoil.to_param}
      expect(assigns(:spoil)).to eq(spoil)
    end
  end

  describe 'POST lock' do
    it 'should send message to lock a plate' do
      allow(ActionCable.server).to receive(:broadcast).with("game_channel_#{@current_game.id}", {state: Plate.first.code, action: "lock", player: @player})
      post :lock, params: {code: Plate.first.code }
      expect(assigns(:plate)).to eq Plate.first
    end
  end

  describe 'DELETE unlock' do
    it 'should send a message to unlock a plate' do
      allow(ActionCable.server).to receive(:broadcast).with("game_channel_#{@current_game.id}", {state: Plate.first.code, action: "unlock"})
      delete :unlock, params: {code: Plate.first.code }
    end
  end

  describe 'POST create' do

    before(:each) do
      #post :create, params: {code: Plate.first.code, id: Plate.first.id, current_location: '41.704812499999996|-86.2334759'}
    end

    it 'should be successful' do
      request.accept = "application/json"
      post :create, params: {code: Plate.first.code, id: Plate.first.id, current_location: '41.704812499999996|-86.2334759'}
      expect(response.response_code).to eq 201
      expect(response).to be_successful
    end

    it 'should create a spoil' do
      request.accept = "application/json"
      post :create, params: {code: Plate.first.code, id: Plate.first.id, current_location: '41.704812499999996|-86.2334759'}
      expect(assigns(:spoil)).to_not be_nil
    end
  end

  describe 'GET avatar' do

  end

  describe 'POST clear' do

  end

end
