CACHE = {}

lines = File.readlines("input.txt", chomp: true).map do |line|
  status, counts = line.split
  counts = counts.split(",").map(&:to_i)

  [([status] * 5).join("?"), counts * 5]
end

def check(status, counts, c, buf, count = -1, mi = 0, ni = 0)
  key = status[mi..].hash + [count, c, buf, mi, ni, *counts].hash
  return CACHE[key] if CACHE[key]

  return 0 if status[mi] != c && status[mi] != "?"
  return 0 if ni >= counts.size && c == "#"

  if c == "#"
    count -= 1
  elsif c == "." && status[mi] == "?"
    buf -= 1
  end

  return 1 if mi + 1 == status.size && (ni == counts.size || ni + 1 == counts.size && count == 0)
  return 0 if buf < 0

  CACHE[key] = (
      if count == 0
        check(status, counts, ".", buf, -1, mi + 1, ni + 1)
      elsif count > 0
        check(status, counts, "#", buf, count, mi + 1, ni)
      else
        check(status, counts, "#", buf, counts[ni], mi + 1, ni) +
          check(status, counts, ".", buf, -1, mi + 1, ni)
      end)
end

r = lines.map do |(status, counts)|
  buf = status.count("?") - (counts.sum - status.count("#"))

  check(status, counts, "#", buf, counts[0]) + check(status, counts, ".", buf)
end.sum

p r
