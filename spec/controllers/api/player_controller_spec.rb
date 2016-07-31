require 'rails_helper'

RSpec.describe Api::PlayerController, :type => :controller do

  describe "GET lookup" do
    it "returns http success" do
      get :lookup
      expect(response).to have_http_status(:success)
    end
  end

end
