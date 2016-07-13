require 'csv'
# setup plates with geo code

CSV.foreach("script/states.csv") do |row|
    state_coords = LocationService.lookup(row[0])
    p = Plate.where(state: row[0], code: row[1]).first_or_initialize
    p.geocode= "#{state_coords["lat"]}|#{state_coords["lng"]}"
    p.save
    sleep 1
end

# create basic table data
GameType.create!(name: "Collaborate")
GameType.create!(name: "Combat")

# make sure jearpster is an admin
me = Player.where(email: 'jearpster@gmail.com').first_or_initialize
me.is_super = true
me.save
