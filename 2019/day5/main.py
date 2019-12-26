import os

file = open(os.path.join(os.getcwd(), os.path.dirname(__file__), "input.txt"), "r")
contents = [int(s) for s in file.read().strip().split(',')]
pointer = 0

def add():
  global pointer
  operation = str(contents[pointer])
  modes = operation[0:-2]

  firstParamMode = int(modes[-1]) if -len(modes) <= -1 < len(modes) else 0
  secondParamMode = int(modes[-2]) if -len(modes) <= -2 < len(modes) else 0

  firstParam = contents[contents[pointer + 1]] if firstParamMode == 0 else contents[pointer + 1]
  secondParam = contents[contents[pointer + 2]] if secondParamMode == 0 else contents[pointer + 2]

  contents[contents[pointer + 3]] = firstParam + secondParam
  pointer += 4

def multiply():
  global pointer
  operation = str(contents[pointer])
  modes = operation[0:-2]

  firstParamMode = int(modes[-1]) if -len(modes) <= -1 < len(modes) else 0
  secondParamMode = int(modes[-2]) if -len(modes) <= -2 < len(modes) else 0

  firstParam = contents[contents[pointer + 1]] if firstParamMode == 0 else contents[pointer + 1]
  secondParam = contents[contents[pointer + 2]] if secondParamMode == 0 else contents[pointer + 2]

  contents[contents[pointer + 3]] = firstParam * secondParam
  pointer += 4

def read():
  global pointer
  contents[contents[pointer + 1]] = 5
  pointer += 2

def output():
  global pointer
  operation = str(contents[pointer])
  modes = operation[0:-2]

  firstParamMode = int(modes[-1]) if -len(modes) <= -1 < len(modes) else 0

  firstParam = contents[contents[pointer + 1]] if firstParamMode == 0 else contents[pointer + 1]

  print(firstParam)
  pointer += 2

def jumpIfTrue():
  global pointer
  operation = str(contents[pointer])
  modes = operation[0:-2]

  firstParamMode = int(modes[-1]) if -len(modes) <= -1 < len(modes) else 0
  secondParamMode = int(modes[-2]) if -len(modes) <= -2 < len(modes) else 0

  firstParam = contents[contents[pointer + 1]] if firstParamMode == 0 else contents[pointer + 1]
  secondParam = contents[contents[pointer + 2]] if secondParamMode == 0 else contents[pointer + 2]

  if firstParam != 0:
    pointer = secondParam
  else:
    pointer += 3

def jumpIfFalse():
  global pointer
  operation = str(contents[pointer])
  modes = operation[0:-2]

  firstParamMode = int(modes[-1]) if -len(modes) <= -1 < len(modes) else 0
  secondParamMode = int(modes[-2]) if -len(modes) <= -2 < len(modes) else 0

  firstParam = contents[contents[pointer + 1]] if firstParamMode == 0 else contents[pointer + 1]
  secondParam = contents[contents[pointer + 2]] if secondParamMode == 0 else contents[pointer + 2]

  if firstParam == 0:
    pointer = secondParam
  else:
    pointer += 3

def lessThan():
  global pointer
  operation = str(contents[pointer])
  modes = operation[0:-2]

  firstParamMode = int(modes[-1]) if -len(modes) <= -1 < len(modes) else 0
  secondParamMode = int(modes[-2]) if -len(modes) <= -2 < len(modes) else 0

  firstParam = contents[contents[pointer + 1]] if firstParamMode == 0 else contents[pointer + 1]
  secondParam = contents[contents[pointer + 2]] if secondParamMode == 0 else contents[pointer + 2]

  if firstParam < secondParam:
    contents[contents[pointer + 3]] = 1
  else:
    contents[contents[pointer + 3]] = 0

  pointer += 4

def equals():
  global pointer
  operation = str(contents[pointer])
  modes = operation[0:-2]

  firstParamMode = int(modes[-1]) if -len(modes) <= -1 < len(modes) else 0
  secondParamMode = int(modes[-2]) if -len(modes) <= -2 < len(modes) else 0

  firstParam = contents[contents[pointer + 1]] if firstParamMode == 0 else contents[pointer + 1]
  secondParam = contents[contents[pointer + 2]] if secondParamMode == 0 else contents[pointer + 2]

  if firstParam == secondParam:
    contents[contents[pointer + 3]] = 1
  else:
    contents[contents[pointer + 3]] = 0

  pointer += 4

def end():
  exit()

switcher = {
  1: add,
  2: multiply,
  3: read,
  4: output,
  5: jumpIfTrue,
  6: jumpIfFalse,
  7: lessThan,
  8: equals
}

while True:
  operation = str(contents[pointer])
  opcode = int(operation[-2:])
  switcher.get(opcode, end)()
