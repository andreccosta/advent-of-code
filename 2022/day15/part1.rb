require 'set'

class Sensor
  attr_reader :x, :y, :range

  def initialize(x, y, beacon_x, beacon_y)
    @x = x
    @y = y
    @range = distance(x, y, beacon_x, beacon_y)
  end
end

def distance(x1, y1, x2, y2)
  (y2 - y1).abs + (x2 - x1).abs
end

lines = File.readlines("input.txt", chomp: true)

map = Set.new
sensors = []

lines.each do |line|
  sensor_x, sensor_y, beacon_x, beacon_y = line.scan(/-?\d+/).map(&:to_i)

  sensor = Sensor.new(sensor_x, sensor_y, beacon_x, beacon_y)
  sensors << sensor

  map << [sensor_x, sensor_y]
  map << [beacon_x, beacon_y]
end

y = 2000000

def to_range(map, sensor, y)
  return nil unless y <= sensor.y + sensor.range && y >= sensor.y - sensor.range

  y_distance = (sensor.y - y).abs
  left = sensor.x - (sensor.range - y_distance)
  right = sensor.x + (sensor.range - y_distance)

  (left..right)
end

ranges = sensors.map { |sensor| to_range(map, sensor, y) }.compact

min_x = ranges.map(&:min).min
max_x = ranges.map(&:max).max

impossibles = (min_x..max_x).select do |x|
  ranges.any? { |range| range.cover?(x) } && !map.include?([x, y])
end

p impossibles.size
