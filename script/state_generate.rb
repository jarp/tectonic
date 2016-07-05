require 'csv'
CSV.foreach("script/states.csv") do |row|
  Plate.create!(state: row[0], code: row[1])
end

GameType.create!(name: "Collaborate")
GameType.create!(name: "Combat")
