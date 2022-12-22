lines = File.readlines("input.txt", chomp: true)

map = {}

lines.each do |line|
  name, parts = line.split(": ")
  map[name] = parts.match?(/\d+/) ? parts.to_i : parts.split
end

def get(map, name)
  parts = map[name]

  return parts if parts.is_a?(Numeric)

  arg1 = get(map, parts.first)
  arg2 = get(map, parts.last)

  map[name] =
    case parts[1]
    when "+"
      arg1 + arg2
    when "-"
      arg1 - arg2
    when "*"
      arg1 * arg2
    when "/"
      arg1 / arg2
    end
end

p get(map, "root")
