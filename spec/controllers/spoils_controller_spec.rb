require 'rails_helper'
require 'support/shared_contexts/sessions'
require 'support/shared_contexts/current_game'

RSpec.describe SpoilsController, :type => :controller do
  include_context "sessions"
  include_context "current_game"

  let (:valid_params) {
    {code: Plate.first.code, id: Plate.first.id, current_location: '41.704812499999996|-86.2334759'}
  }

  before(:each) do
  login_as(@player)
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
      request.accept = "application/json"

    end

    it 'should be successful' do
      post :create, params: {code: Plate.first.code, id: Plate.first.id, current_location: '41.704812499999996|-86.2334759'}
      expect(response.response_code).to eq 201
      expect(response).to be_successful
    end

    it 'should create a spoil' do
      post :create, params: {code: Plate.first.code, id: Plate.first.id, current_location: '41.704812499999996|-86.2334759'}
      expect(assigns(:spoil)).to_not be_nil
    end

    it 'should broadcast a message' do
      allow(ActionCable.server).to receive(:broadcast).with( "game_channel_#{cookies["current_game_id"]}",
        {
          message: "Tester found the plate for  #{Plate.first.state} for 7 points.",
          state: Plate.first.code,
          player_name: 'Tester',
          player: @player,
          points: 7,
          bonus: false,
          action: "spoil"
        }
        )
        post :create, params: {code: Plate.first.code, id: Plate.first.id, current_location: '41.704812499999996|-86.2334759'}
    end

    it 'should award double bonus if state is found as a bonus' do
      Bonus.create!(game: @current_game, plate: Plate.first)
      post :create, params: valid_params
      expect(assigns(:spoil).points).to eq 14
    end

    it 'should crate a timeline entry' do
      expect {
        post :create, params: valid_params
      }.to change(Timeline, :count).by(1)
    end

  end

  describe 'GET avatar' do

  end

  describe 'POST clear' do

  end

end
