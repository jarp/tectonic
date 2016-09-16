# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require 'spec_helper'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'support/helpers/session'
# Add additional requires below this line. Rails is not loaded until this point!

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
# Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
# ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!
  #Player.destroy_all

  # Plate.destroy_all
  # Plate.create(code: 'AL', state: 'Alabama', geocode: '32.3182314|-86.902298')
  # Plate.create(code: 'AK', state: 'Alaska', geocode: '64.2008413|-149.4936733')
  # Plate.create(code: 'AZ', state: 'Arizona', geocode: '34.0489281|-111.0937311')
  # Plate.create(code: 'AR', state: 'Arkansas', geocode: '35.20105|-91.8318334')
  # Plate.create(code: 'CA', state: 'California', geocode: '36.778261|-119.4179324')
  # Plate.create(code: 'CO', state: 'Colorado', geocode: '39.5500507|-105.7820674')
  # Plate.create(code: 'CT', state: 'Connecticut', geocode: '41.6032207|-73.087749')
  # Plate.create(code: 'DE', state: 'Delaware', geocode: '38.9108325|-75.52766989999999')
  # Plate.create(code: 'DC', state: 'District of Columbia', geocode: '38.9059849|-77.03341790000002')
  # Plate.create(code: 'FL', state: 'Florida', geocode: '27.6648274|-81.5157535')
  # Plate.create(code: 'GA', state: 'Georgia', geocode: '32.1656221|-82.9000751')
  # Plate.create(code: 'HI', state: 'Hawaii', geocode: '19.8967662|-155.5827818')
  # Plate.create(code: 'ID', state: 'Idaho', geocode: '44.0682019|-114.7420408')
  # Plate.create(code: 'IL', state: 'Illinois', geocode: '40.6331249|-89.3985283')
  # Plate.create(code: 'IN', state: 'Indiana', geocode: '40.2671941|-86.1349019')
  # Plate.create(code: 'IA', state: 'Iowa', geocode: '41.8780025|-93.097702')
  # Plate.create(code: 'KS', state: 'Kansas', geocode: '39.011902|-98.4842465')
  # Plate.create(code: 'KY', state: 'Kentucky', geocode: '37.8393332|-84.2700179')
  # Plate.create(code: 'LA', state: 'Louisiana', geocode: '30.9842977|-91.96233269999999')
  # Plate.create(code: 'ME', state: 'Maine', geocode: '45.253783|-69.4454689')
  # Plate.create(code: 'MD', state: 'Maryland', geocode: '39.0457549|-76.64127119999999')
  # Plate.create(code: 'MA', state: 'Massachusetts', geocode: '42.4072107|-71.3824374')
  # Plate.create(code: 'MI', state: 'Michigan', geocode: '44.3148443|-85.60236429999999')
  # Plate.create(code: 'MN', state: 'Minnesota', geocode: '46.729553|-94.6858998')
  # Plate.create(code: 'MS', state: 'Mississippi', geocode: '32.3546679|-89.3985283')
  # Plate.create(code: 'MO', state: 'Missouri', geocode: '37.9642529|-91.8318334')
  # Plate.create(code: 'MT', state: 'Montana', geocode: '46.8796822|-110.3625658')
  # Plate.create(code: 'NE', state: 'Nebraska', geocode: '41.4925374|-99.9018131')
  # Plate.create(code: 'NV', state: 'Nevada', geocode: '38.8026097|-116.419389')
  # Plate.create(code: 'NH', state: 'New Hampshire', geocode: '43.1938516|-71.5723953')
  # Plate.create(code: 'NJ', state: 'New Jersey', geocode: '40.0583238|-74.4056612')
  # Plate.create(code: 'NM', state: 'New Mexico', geocode: '34.5199402|-105.8700901')
  # Plate.create(code: 'NY', state: 'New York', geocode: '43.2994285|-74.21793260000001')
  # Plate.create(code: 'NC', state: 'North Carolina', geocode: '35.7595731|-79.01929969999999')
  # Plate.create(code: 'ND', state: 'North Dakota', geocode: '47.5514926|-101.0020119')
  # Plate.create(code: 'OH', state: 'Ohio', geocode: '40.4172871|-82.90712300000001')
  # Plate.create(code: 'OK', state: 'Oklahoma', geocode: '35.0077519|-97.092877')
  # Plate.create(code: 'OR', state: 'Oregon', geocode: '43.8041334|-120.5542012')
  # Plate.create(code: 'PA', state: 'Pennsylvania', geocode: '41.2033216|-77.1945247')
  # Plate.create(code: 'RI', state: 'Rhode Island', geocode: '41.5800945|-71.4774291')
  # Plate.create(code: 'SC', state: 'South Carolina', geocode: '33.836081|-81.1637245')
  # Plate.create(code: 'SD', state: 'South Dakota', geocode: '43.9695148|-99.9018131')
  # Plate.create(code: 'TN', state: 'Tennessee', geocode: '35.5174913|-86.5804473')
  # Plate.create(code: 'TX', state: 'Texas', geocode: '31.9685988|-99.9018131')
  # Plate.create(code: 'UT', state: 'Utah', geocode: '39.3209801|-111.0937311')
  # Plate.create(code: 'VT', state: 'Vermont', geocode: '44.5588028|-72.57784149999999')
  # Plate.create(code: 'VA', state: 'Virginia', geocode: '37.4315734|-78.6568942')
  # Plate.create(code: 'WA', state: 'Washington', geocode: '47.7510741|-120.7401386')
  # Plate.create(code: 'WV', state: 'West Virginia', geocode: '38.5976262|-80.4549026')
  # Plate.create(code: 'WI', state: 'Wisconsin', geocode: '43.7844397|-88.7878678')
  # Plate.create(code: 'WY', state: 'Wyoming', geocode: '43.0759678|-107.2902839')
  #
  # # create basic table data
  # GameType.destroy_all
  # GameType.create!(name: "Collaborate")
  # GameType.create!(name: "Combat")
end
