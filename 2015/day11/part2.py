import re

alphabet = 'abcdefghijklmnopqrstuvwxyz'


def find_sequences(password):
    sequence = [alphabet.index(m) + 1 for m in password]

    curr = []
    prev = sequence[0]

    for x in sequence[1:]:
        if x - prev == 1:
            curr.append(x)
            if len(curr) >= 3:
                return True
        else:
            curr = [x]

        prev = x

    return False


def next_letter(letter):
    return alphabet[(alphabet.index(letter) + 1) % len(alphabet)]


def next_password(password):
    for idx, x in enumerate(reversed(password)):
        nl = next_letter(x)
        password = replace_char_at(password, len(password) - 1 - idx, nl)

        if (nl) != 'a':
            return password


def count_pairs(password):
    pairs = [m.group() for m in re.finditer(r'((\w)\2){1}', password)]
    return len(pairs)


def replace_char_at(org_str, index, repl):
    new_str = org_str
    if index < len(org_str):
        new_str = org_str[0:index] + repl + org_str[index + 1:]
    return new_str


def is_valid(password):
    return len(password) == 8 and \
        (1 not in [c in password for c in ['i', 'o', 'l']]) and \
        (count_pairs(password) >= 2) and \
        find_sequences(password)


password = next_password('hepxxyzz')

while not is_valid(password):
    password = next_password(password)

print(password)
