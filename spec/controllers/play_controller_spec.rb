require 'rails_helper'
require 'support/shared_contexts/sessions'
require 'support/shared_contexts/current_game'
RSpec.describe PlayController, :type => :controller do
  include_context "sessions"
  include_context "current_game"

  before(:each) do
    login_as(@player)
  end

  describe "GET index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'sets a bunch of instance variables for start of game' do
      get :index
      expect(assigns(:current_plates).count).to eq 0
      expect(assigns(:players)).to_not be_nil
      expect(assigns(:plates)).to_not be_nil
      expect(assigns(:spoils)).to be_empty
      expect(assigns(:table)).to_not be_nil
      expect(assigns(:leaders)).to_not be_nil
      expect(assigns(:percent_done)).to_not be_nil
    end
  end

  describe "GET table" do
    it "returns http success" do
      get :table
      expect(response).to have_http_status(:success)
    end

    it "returns leaders" do
      get :table
      expect(assigns(:leaders)).to_not be_nil
    end

  end

  describe "GET set" do
    before(:each) do
      @new_game = FactoryGirl.create(:game)
    end

    it "redirects to play controller" do
      get :set, params: {id: @new_game.id}
      expect(response).to redirect_to current_game_path
    end

    it "returns leaders" do
      get :set, params: {id: @new_game.id}
      expect(cookies[:current_game_id].to_i).to eq @new_game.id.to_i
    end
  end

  def set
    cookies[:current_game_id] = params[:id]
    redirect_to current_game_path
  end


end
