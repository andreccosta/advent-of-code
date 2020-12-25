file = open('input.txt', 'r')
cardpk, doorpk = [int(x) for x in file.read().splitlines()]

sn = 7


def _calculate_ls(sn, t):
    ls = 0
    v = 1

    while v != t:
        v = (v * sn) % 20201227
        ls += 1

    return ls


def _calculate_ek(sn, ls):
    v = 1

    for _ in range(ls):
        v = (v * sn) % 20201227

    return v


cardls = _calculate_ls(sn, cardpk)
ek = _calculate_ek(doorpk, cardls)

print(ek)
