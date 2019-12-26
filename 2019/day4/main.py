# password range 265275-781584

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
  return len(digits) != len(set(digits))

for x in range(start, end):
  if not checkIncremental(x):
    continue

  if not checkDuplicates(x):
    continue

  count += 1

print(count)
