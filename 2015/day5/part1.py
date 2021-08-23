content = open('input.txt', 'r').read()
lines = content.splitlines()

vowels = 'aeiou'
banlist = ['ab', 'cd', 'pq', 'xy']


def _is_vowel(char):
    return char in vowels


def _validate(string):
    prev = None
    vowels_count = 0
    repeated = False

    for char in string:
        if _is_vowel(char):
            vowels_count += 1
        if char == prev:
            repeated = True
        prev = char

    return vowels_count >= 3 and \
        repeated and \
        all(not word in string for word in banlist)


print(sum(_validate(line) for line in lines))
