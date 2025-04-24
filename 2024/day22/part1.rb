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

p seeds.sum { |seed| secrets(seed).last }
