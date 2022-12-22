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

map["humn"] = false
value = 0
monkey = "root"

while monkey != "humn"
  args = [map[monkey][0], map[monkey][2]]

  try = args.find do |var|
    get(map, var)
    false
  rescue
    true
  end

  result = get(map, args.find { |v| v != try })
  op = map[monkey][1]

  if monkey == "root"
    value = result
  else
    case op
    when "+"
      value -= result
    when "-"
      if map[monkey][0] == try
        value += result
      else
        value = result - value
      end
    when "*"
      value /= result
    when "/"
      if map[monkey][0] == try
        value *= result
      else
        value = result / value
      end
    end
  end

  monkey = try
end

p value
