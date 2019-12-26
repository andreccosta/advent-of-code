start = 265275
end = 781584
count = 0

def checkIncremental(x):
  previous = 0

  for x in map(int, str(x)):
    if x < previous:
      return False
    previous = x

  return True

def checkDuplicates(x):
  digits = str(x)
  counters = dict((i, digits.count(i)) for i in digits)

  return any(x > 1 and x == 2 for x in counters.values())

for x in range(start, end):
  if checkIncremental(x) and checkDuplicates(x):
    count += 1

print(count)
