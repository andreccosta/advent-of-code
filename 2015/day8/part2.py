content = open('input.txt', 'r').read()
lines = content.strip().splitlines()

char_codes = 0
char_values = 0

for line in lines:
    char_codes += len(line)
    char_values += 2 + len(line.replace('\\', '\\\\').replace('"', '\\"'))

print(char_values - char_codes)
