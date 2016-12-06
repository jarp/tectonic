RSpec.shared_context "sessions" do

  before(:all) do
    puts "create player for session"
    @player = FactoryGirl.create(:player, first_name: 'Tester', last_name: 'McTestie', email: "test-#{SecureRandom.hex(5)}@test.com")
  end

  after(:all) do
    @player.destroy
  end

  let(:valid_session){
    { 'id' => @player.id, 'netid' => @player.email, first_name: @player.first_name, last_name: @player.last_name, is_super: false  }
  }

  let(:valid_super_session){
    { 'id' => @player.id, 'netid' => @player.email, first_name: @player.first_name, last_name: @player.last_name, is_super: true }
  }

  let(:invalid_session){
    { }
  }


end
