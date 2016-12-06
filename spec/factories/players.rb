FactoryGirl.define do
  factory :player do
    email "player-#{SecureRandom.hex(4)}@test.com"
  end
end
