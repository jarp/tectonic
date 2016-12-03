FactoryGirl.define do
  factory :game do
    title "Test Game"
    game_type GameType.first || GameType.create!(name: 'Combative')
  end
end
