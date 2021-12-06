line = open('input.txt').read()
state = [int(x) for x in line.split(',')]

def step(state):
    for i in range(len(state)):
        if state[i] == 0:
            state[i] = 6
            state.append(8)
        else:
            state[i] -= 1


for i in range(256):
    print(i)
    step(state)

print(len(state))
