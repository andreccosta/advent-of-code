map = File.readlines("input.txt", chomp: true)
  .map { |line| line.chars }

DIRS = [[0, 1], [1, 0], [0, -1], [-1, 0]]
COLS = map[0].size
ROWS = map.size

def step(map, queue)
  queue.flat_map do |pos|
    DIRS.filter_map do |dir|
      map_pos = [((pos[0] + dir[0]) % ROWS), ((pos[1] + dir[1]) % COLS)]
      next_pos = pos.zip(dir).map(&:sum)

      next if map_pos[0] < 0 || map_pos[1] < 0 || map_pos[0] >= COLS || map_pos[1] >= ROWS ||
        map[map_pos[1]][map_pos[0]] == "#"

      next_pos
    end
  end.uniq
end

start = map.flatten.index("S")&.divmod(map.first.size)

queue = [start]
prev_queue_size = nil
diffs = []
incs = []

steps = 1000.times do |i|
  idx = i % COLS

  queue = step(map, queue)

  diff = queue.size - prev_queue_size if prev_queue_size
  diff_diff = diff - diffs[idx] if diffs[idx]

  break i if incs[idx] && incs[idx] == diff_diff

  prev_queue_size = queue.size
  diffs[idx] = diff
  incs[idx] = diff_diff
end

t = prev_queue_size

(26501365 - steps).times do |i|
  idx = i + 1
  inc = diffs[idx % COLS] + incs[idx % COLS]
  diffs[idx % COLS] = inc
  t += inc
end

p t
