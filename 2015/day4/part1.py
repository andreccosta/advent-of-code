import hashlib

key = "iwrupvqb"


def _hash(key, nbr):
    result = hashlib.md5((key + nbr).encode())
    return result.hexdigest()


for i in range(1, 10 ** len(key)):
    hash = _hash(key, str(i))

    if hash.startswith("00000"):
        print(i)
        exit(0)
