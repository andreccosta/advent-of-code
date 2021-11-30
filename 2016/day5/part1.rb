require 'digest'

door_id = "wtnhxymk"
i = 0
password = ""

while password.size < 8
    hex = Digest::MD5.hexdigest(door_id + i.to_s)
    password << hex.chars[5] if hex.start_with?('00000')
    i += 1
end

p password
