FactoryGirl.define do
  factory :spoil do
    game Game.first || FactoryGirl.create(:game)
    player Player.first || FactoryGirl.create(:player)
    plate Plate.first || FactoryGirl.create(:plate)
    points 1
  end
end
