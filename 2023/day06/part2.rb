lines = File.readlines("input.txt", chomp: true)

times, distances = lines
time = times.split(":").last.gsub(/[^\d]+/, "").to_i
record_distance = distances.split(":").last.gsub(/[^\d]+/, "").to_i

acc = (1...time).count do |hold_time|
  distance = hold_time * (time - hold_time)
  distance > record_distance
end

p acc
