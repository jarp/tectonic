FactoryGirl.define do
  factory :game do
    title "Test Game"
    game_type_id GameType.first.id || GameType.create!(name: 'Combative')
  end
end
