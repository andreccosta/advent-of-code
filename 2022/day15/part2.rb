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

def remove_range(ranges, range_to_remove)
  return if range_to_remove.nil?

  ranges
    .map { |range|
      if range_to_remove.cover?(range)
        nil
      elsif range.cover?(range_to_remove)
        [(range.begin..(range_to_remove.begin - 1)), ((range_to_remove.end + 1)..range.end)]
      elsif range_to_remove.cover?(range.begin)
        ((range_to_remove.end + 1)..range.end)
      elsif range_to_remove.cover?(range.end)
        (range.begin..(range_to_remove.begin - 1))
      else
        range
      end
    }
    .flatten
    .compact
    .select { |r| r.size > 0 }
end

lines = File.readlines("input.txt", chomp: true)

sensors = []

lines.each do |line|
  sensor_x, sensor_y, beacon_x, beacon_y = line.scan(/-?\d+/).map(&:to_i)

  sensor = Sensor.new(sensor_x, sensor_y, beacon_x, beacon_y)
  sensors << sensor
end

def to_range(sensor, y)
  return nil unless y <= sensor.y + sensor.range && y >= sensor.y - sensor.range

  y_distance = (sensor.y - y).abs
  x_range = (sensor.range - y_distance)

  (sensor.x - x_range..sensor.x + x_range)
end

min = 0
min = 4000000

result = (min..max).each do |y|
  ranges = [(min..max)]

  sensors.each do |sensor|
    range = to_range(sensor, y)
    next if range.nil?

    ranges = remove_range(ranges, range)
  end

  x = ranges.first&.first
  break [x, y] if x
end

p result.first * 4000000 + result.last
