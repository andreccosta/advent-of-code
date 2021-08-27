content = open('input.txt', 'r').read()
lines = content.strip().splitlines()

char_codes = 0
char_values = 0

for line in lines:
    char_codes += len(line)
    char_values += len(line[1:-1].encode('utf-8').decode('unicode_escape'))

print(char_codes - char_values)
