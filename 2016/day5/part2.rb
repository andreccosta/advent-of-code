require 'digest'

door_id = "wtnhxymk"
i = 0
password = "        "

while password =~ /\s/ do
    hex = Digest::MD5.hexdigest(door_id + i.to_s)

    if hex.start_with?('00000') && hex[5].match(/[0-7]/)
        position = hex.chars[5].to_i

	if password[position] == ' '
	    password[position] = hex.chars[6]
            p password
        end
    end

    i += 1
end

p password
