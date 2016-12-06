RSpec.shared_context "plates" do

  before(:all) do
    Plate.where(state: 'Michigan', code: 'MI', geocode: '13245|345').first_or_create
    Plate.where(state: 'Kentucky', code: 'KY', geocode: '13245|345').first_or_create
    Plate.where(state: 'Tennessee', code: 'TN', geocode: '13245|345').first_or_create
  end

  after(:each) do
    # Plate.destroy_all
  end

end
