target = File.read("input.txt")
  .split(': ').last
  .split(', ').map { |s| s.split('=')}.map(&:last)
  .map{ |str| s, e = str.split('..'); s.to_i..e.to_i }

def step(pos, velocity)
  new_pos = [pos[0] + velocity[0], pos[1] + velocity[1]]
  new_velocity = [velocity[0] > 0 ? velocity[0] - 1 : 0, velocity[1] - 1]

  [new_pos, new_velocity]
end

def factorial_sum(n)
  (n**2 + n) / 2
end

def first_factorial_sum(target)
  n = 0

  while true
    return n if factorial_sum(n) > target
    n += 1
  end
end

low_vel_x = first_factorial_sum(target[0].first)
high_vel_x = target[0].last
low_vel_y = target[1].first
high_vel_y = -target[1].first

initial_velocities = []

(low_vel_x..high_vel_x).each do |velocity_x|
  (low_vel_y..high_vel_y).each do |velocity_y|
    pos = [0, 0]
    velocity = [velocity_x, velocity_y]
    best_height = 0

    while true
      pos, velocity = step(pos, velocity)

      best_height = pos[1] if pos[1] > best_height
      # hit
      if target[0].include?(pos[0]) && target[1].include?(pos[1])
        initial_velocities << [velocity_x, velocity_y]
        break
      end

      # missed
      if pos[0] > target[0].last || pos[1] < target[1].first
        break
      end
    end
  end
end

pp initial_velocities.length
