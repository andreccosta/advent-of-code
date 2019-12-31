class IntCode {
  inputs = []
  outputs = []

  constructor(i) {
    this.inputs = i
  }

  process(program) {
    const codes = program.split(',').map(code => Number(code))
    let pointer = 0
    let inputPointer = 0
    let isComplete = false

    const parseInstruction = (instruction) => {
      let str = String(instruction)
      let opCode = Number(str.substring(str.length - 2, str.length))
      let modes = str.length > 2 ?
        [...str.substring(0, str.length - 2)].map(Number).reverse() :
        []

      return {
        opCode,
        modes
      }
    }

    const getParam = (mode, index) => {
      return mode ? codes[index] : codes[codes[index]]
    }

    const getParams = (count, modes) => {
      let parameters = []

      for (let i = 0; i < count; i++) {
        parameters.push(getParam(modes[i], pointer + i + 1))
      }

      return parameters
    }

    const add = (modes) => {
      let [first, second] = getParams(2, modes)

      codes[codes[pointer + 3]] = first + second

      pointer += 4
    }

    const multiply = (modes) => {
      let [first, second] = getParams(2, modes)

      codes[codes[pointer + 3]] = first * second

      pointer += 4
    }

    const read = (modes) => {
      codes[codes[pointer + 1]] = this.inputs[inputPointer++]
      pointer += 2
    }

    const output = (modes) => {
      let [first] = getParams(1, modes)
      this.outputs.push(first)
      pointer += 2
    }

    const jumpIfTrue = (modes) => {
      let [first, second] = getParams(2, modes)

      if (first)
        pointer = second
      else
        pointer += 3
    }

    const jumpIfFalse = (modes) => {
      let [first, second] = getParams(2, modes)

      if(!first)
        pointer = second
      else
        pointer += 3
    }

    const lessThan = (modes) => {
      let [first, second] = getParams(2, modes)

      if (first < second)
        codes[codes[pointer + 3]] = 1
      else
        codes[codes[pointer + 3]] = 0

      pointer += 4
    }

    const equals = (modes) => {
      let [first, second] = getParams(2, modes)

      if (first == second)
        codes[codes[pointer + 3]] = 1
      else
        codes[codes[pointer + 3]] = 0

      pointer += 4
    }

    const end = () => {
      isComplete = true
    }

    const operations = {
      1: add,
      2: multiply,
      3: read,
      4: output,
      5: jumpIfTrue,
      6: jumpIfFalse,
      7: lessThan,
      8: equals,
      99: end
    }

    do {
      let { opCode, modes } = parseInstruction(codes[pointer])

      let operation = operations[opCode]

      operation(modes)
    } while(!isComplete)

    return this.outputs
  }
}

module.exports = IntCode
