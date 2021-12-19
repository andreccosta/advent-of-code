MIN_OVERLAP = 12

reports = File.read("input.txt")
  .split(/\n?--- scanner \d+ ---\n/)
  .map { |c| c.split("\n").map { |e| e.split(",").map(&:to_i) } }
  .reject(&:empty?)

class Scanner
  attr_accessor :position, :transform
  attr_reader :beacons, :distances, :name

  def initialize(name)
    @name = name
    @beacons = []
  end

  def update_beacons
    @beacons.each { |b| b.set_absolute_position(@position, @transform) }
  end

  def parse_beacons(r)
    @beacons = r.map { |pos| Beacon.new(pos) }

    @distances = @beacons.combination(2).map { |a, b|
      [[a, b], distance(a.relative_position, b.relative_position)]
    }.to_h
  end
end

class Beacon
  attr_accessor :absolute_position, :relative_position

  def initialize(position)
    @relative_position = position
  end

  def set_absolute_position(scanner_position, transform)
    @absolute_position = add_v(apply_transform(@relative_position, transform), scanner_position)
  end
end

def distance(a, b)
  Math.sqrt(a.zip(b).map { |x1, x2| (x1 - x2) ** 2 }.sum)
end

def roll(v)
  c, s = v
  [[c[0], c[2], c[1]], [s[0], s[2], -s[1]]]
end

def turn(v)
  c, s = v
  [[c[1], c[0], c[2]], [-s[1], s[0], s[2]]]
end

def rotations
  v = [[1, 2, 3], [1, 1, 1]]
  r = []

  2.times do
    3.times do
      v = roll(v)
      r << yield(v)
      3.times do
        v = turn(v)
        r << yield(v)
      end
    end
    v = roll(turn(roll(v)))
  end

  r
end

def add_v(v1, v2)
  v1.zip(v2).map { |a, b| a + b }
end

def diff_v(a, b)
  a.zip(b).map { |a, b| a - b }
end

def apply_transform(v, t)
  c, s = t
  [v[c[0] - 1] * s[0], v[c[1] - 1] * s[1], v[c[2] - 1] * s[2]]
end

def common_beacons_pairs(s1, s2)
  beacons_s2 = []

  beacons_s1 = s1.distances.select do |bs, diff|
    match = s2.distances.find { |bs2, diff2| diff == diff2 }

    if match.nil?
      false
    else
      beacons_s2 << match.first
      true
    end
  end

  [beacons_s1.keys, beacons_s2]
end

def find_scanner_position(common_pairs)
  diffs = []

  common_pairs.first.zip(common_pairs.last).each do |x|
    x.first.each do |b_s0|
      x.last.each do |b_s1|
        rotations do |t|
          r = apply_transform(b_s1.relative_position, t)
          diffs << [t, diff_v(b_s0.absolute_position, r)]
        end
      end
    end
  end

  diffs.tally { |x| x.last }.sort_by(&:last).last.first
end

scanners = []

reports.each_with_index do |r, i|
  scanner = Scanner.new("Scanner #{i}")
  scanner.parse_beacons(r)

  if i == 0
    scanner.position = [0, 0, 0]
    scanner.transform = [[1, 2, 3], [1, 1, 1]]
    scanner.update_beacons
  end

  scanners << scanner
end

while scanners.any? { |s| !s.transform }
  scanners.each do |s1|
    scanners.each do |s2|
      next unless s1 != s2 && s1.transform && !s2.transform

      common_pairs = common_beacons_pairs(s1, s2)

      next if common_pairs.first.flatten(1).uniq.length < 12

      s2.transform, s2.position = find_scanner_position(common_pairs)
      s2.update_beacons
    end
  end
end

p scanners.map { |s| s.beacons.map(&:absolute_position) }
  .flatten(1)
  .uniq
  .length
