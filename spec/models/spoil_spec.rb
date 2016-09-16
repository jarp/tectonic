require 'rails_helper'

RSpec.describe Spoil, :type => :model do
  before(:each) do
    @spoil = FactoryGirl.build(:spoil)
  end
  it 'has a player' do
    expect(@spoil).to respond_to :player
  end
end
