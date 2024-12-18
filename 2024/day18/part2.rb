
require 'algorithms'
require 'matrix'

DIRS = [
  Vector[-1, 0],
  Vector[1, 0],
  Vector[0, 1],
  Vector[0, -1]
]

lines = File.readlines("input.txt", chomp: true)
bytes = lines.map { |line| Vector[*line.scan(/-?\d+/).map(&:to_i)] }

def run(bytes, corrupted)
  start = Vector[0, 0]
  finish = Vector[70,70]

  queue = Containers::Queue.new
  queue.push([start, 0])
  visited = Set.new

  until queue.empty?
    pos, step = queue.pop

    next if visited.include?(pos) || corrupted.include?(pos)
    visited << pos

    if pos == finish
      return step
    else
      DIRS.each { |d|
        n_pos = pos + d
        next unless n_pos[0].between?(start[0], finish[0]) && n_pos[1].between?(start[1], finish[1])
        next if corrupted.include?(n_pos) || visited.include?(n_pos)
        queue.push([n_pos, step + 1])
      }
    end
  end
end

count = (1024...bytes.size).bsearch { |i| run(bytes, bytes[0..i].to_set) == nil }
p bytes[count]
