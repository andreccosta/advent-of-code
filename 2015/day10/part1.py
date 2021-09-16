seqeuence = '1321131112'
turns = 40


def run(sequence):
    result = ''
    prev = None
    count = 1

    for x in sequence:
        if x == prev:
            count += 1
        else:
            if prev is not None:
                result += f'{count}{prev}'
            count = 1
            prev = x

    if prev is not None:
        result += f'{count}{prev}'

    return result


for x in range(turns):
    seqeuence = run(seqeuence)

print(len(seqeuence))
