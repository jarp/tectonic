Plate.all.each do | plate |
  puts "Plate.create(code: '#{plate.code}', state: '#{plate.state}', geocode: '#{plate.geocode}')"
end
