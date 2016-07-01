require 'rails_helper'

RSpec.describe PlayController, :type => :controller do

  describe "GET index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET table" do
    it "returns http success" do
      get :table
      expect(response).to have_http_status(:success)
    end
  end

end
