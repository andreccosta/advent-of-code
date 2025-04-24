lines = File.readlines('input.txt', chomp: true)
seeds = lines.map(&:to_i)

def mix_prune(a, b)
  (a ^ b) & 0xffffff
end

def get_next(secret)
  secret = mix_prune(secret, secret << 6)
  secret = mix_prune(secret, secret >> 5)
  secret = mix_prune(secret, secret << 11)
  secret
end

def secrets(seed)
  [seed].tap do |nums|
    2000.times do
      seed = get_next(seed)
      nums << seed
    end
  end
end

def bananas(seed)
  secrets(seed).map { |n| n % 10 }
end

def diffs(arr)
  arr.each_cons(2).map { |a, b| b - a }
end

result = Hash.new(0)

seeds.each do |seed|
  b = bananas(seed)
  d = diffs(b)

  seen = {}

  (0...(d.size - 3)).each do |i|
    slice = d[i, 4]
    next if seen[slice]

    seen[slice] = true
    result[slice] += b[i + 4]
  end
end

p result.max_by(&:last)
