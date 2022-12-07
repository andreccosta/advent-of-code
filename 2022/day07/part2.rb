lines = File.readlines("input.txt", chomp: true)

fs = {}
path = []

def parse_commands(lines)
  commands = []
  command = []

  lines.each do |line|
    if line.start_with?("$")
      if !command.empty?
        commands << command
        command = []
      end
    end

    command << line
  end

  commands << command
  commands
end

def cd(path, arg)
  arg.strip!

  if arg == "/"
    path = []
  elsif arg == ".."
    path.pop
  else
    path << arg
  end

  path
end

def ls(command)
  tree = {}

  command.each do |line|
    first, second = line.split

    tree[second] = if first == "dir"
      {}
    else
      first.to_i
    end
  end

  tree
end

commands = parse_commands(lines)

commands.each do |command|
  type = command.first[2..3]

  case type
  when "cd"
    path = cd(path, command.first[5..])
  when "ls"
    sub_tree = ls(command[1..])

    if path.empty?
      fs.merge!(sub_tree)
    else
      fs.dig(*path).merge!(sub_tree)
    end
  end
end

def calculate_dir_size(sizes, fs)
  size = 0

  fs.each do |key, value|
    size += if value.is_a?(Hash)
      sub_dir_size = calculate_dir_size(sizes, fs[key])

      sizes << sub_dir_size
      sub_dir_size
    else
      value
    end
  end

  size
end

def calculate_dir_sizes(fs)
  sizes = []
  total = calculate_dir_size(sizes, fs)

  [total, sizes]
end

total, sizes = calculate_dir_sizes(fs)

total_space = 70_000_000
required_space = 30_000_000
need_to_clear = required_space - (total_space - total)

p sizes.filter { |v| v >= need_to_clear }.min
