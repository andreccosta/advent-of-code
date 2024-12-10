lines = File.readlines("input.txt", chomp: true)
blocks = lines.first.chars

id = 0
compressed = []
space = false

blocks.each do |c|
  c.to_i.times { compressed << (space ? "." : id) }
  id += 1 unless space
  space = !space
end

spaces = {}

space_start = nil
space_size = 0

compressed.each.with_index do |c, i|
  if c == "."
    space_start ||= i
    space_size += 1
  else
    if space_size > 0
      spaces[space_start] = space_size

      space_start = nil
      space_size = 0
    end
  end
end

file_pos = compressed.length - 1
file_id = id - 1

until file_id < 0 do
  puts "### #{file_id} ###" if file_id % 100 == 0

  while(compressed[file_pos] == "." || compressed[file_pos] > file_id)
    file_pos -= 1
  end

  file_size = 0
  while(compressed[file_pos] == file_id)
    file_pos -= 1
    file_size += 1
  end
  file_pos += 1

  suitable_space = spaces.find { |k, v| v >= file_size }

  if suitable_space
    space_pos, space_size = suitable_space
    spaces.delete(space_pos)

    if space_size > file_size
      spaces[space_pos + (space_size - file_size) + 1] = space_size - file_size
    end

    spaces = spaces.sort_by { |k, v| k }.to_h

    compressed.fill(".", file_pos..(file_pos + file_size - 1))
    compressed.fill(file_id, space_pos..(space_pos + file_size - 1))
  end

  file_id -= 1
end

p compressed.each_with_index.sum { |c, i| c == "." ? 0 : c * i }
