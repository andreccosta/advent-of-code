lines = File.readlines("input.txt", chomp: true)

times, distances = lines
times = times.split(":").last.strip.split.map(&:to_i)
distances = distances.split(":").last.strip.split.map(&:to_i)

races = times.zip(distances).to_h
acc = 1

races.each do |time, record_distance|
  acc *= (1...time).count do |hold_time|
    distance = hold_time * (time - hold_time)
    distance > record_distance
  end
end

p acc
