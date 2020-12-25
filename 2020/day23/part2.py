file = open('input.txt', 'r')
cups = [int(n) for n in list(file.read().strip())]
moves = 1000000


class Node:
    def __init__(self, n):
        self.n = n
        self.next_node = self

    def append(self, n):
        new_node = Node(n)
        new_node.next_node = self.next_node

        self.next_node = new_node

        return self.next_node

    def pop(self):
        ret = self.next_node
        self.next_node = self.next_node.next_node.next_node.next_node
        return ret

    def push(self, node):
        node.next_node.next_node.next_node = self.next_node
        self.next_node = node


nodes = {}
nodes[cups[0]] = current = Node(cups[0])
appender = current

for number in cups[1:]:
    nodes[number] = appender = appender.append(number)

for i in range(len(cups) + 1, moves + 1):
    nodes[i] = appender = appender.append(i)

for i in range(moves * 10):
    taken = current.pop()
    taken_n = {taken.n, taken.next_node.n, taken.next_node.next_node.n}

    label = (current.n - 1)

    if label == 0:
        label = moves

    while label in taken_n:
        label = (label - 1)

        if label == 0:
            label = moves

    nodes[label].push(taken)

    current = current.next_node

print(nodes[1].next_node.n * nodes[1].next_node.next_node.n)
