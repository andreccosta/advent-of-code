class IntCode {
  isComplete = false
  pointer = 0

  constructor(program) {
    this.codes = program.split(',').map(code => Number(code))
  }

  process(inputs) {
    let inputsPointer = 0

    if(this.isComplete)
      return

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
      return mode ? this.codes[index] : this.codes[this.codes[index]]
    }

    const getParams = (count, modes) => {
      let parameters = []

      for (let i = 0; i < count; i++) {
        parameters.push(getParam(modes[i], this.pointer + i + 1))
      }

      return parameters
    }

    const add = (modes) => {
      let [first, second] = getParams(2, modes)

      this.codes[this.codes[this.pointer + 3]] = first + second

      this.pointer += 4
    }

    const multiply = (modes) => {
      let [first, second] = getParams(2, modes)

      this.codes[this.codes[this.pointer + 3]] = first * second

      this.pointer += 4
    }

    const read = (modes) => {
      this.codes[this.codes[this.pointer + 1]] = inputs[inputsPointer++]
      this.pointer += 2
    }

    const output = (modes) => {
      let [first] = getParams(1, modes)
      this.pointer += 2
      return first
    }

    const jumpIfTrue = (modes) => {
      let [first, second] = getParams(2, modes)

      if (first)
        this.pointer = second
      else
        this.pointer += 3
    }

    const jumpIfFalse = (modes) => {
      let [first, second] = getParams(2, modes)

      if(!first)
        this.pointer = second
      else
        this.pointer += 3
    }

    const lessThan = (modes) => {
      let [first, second] = getParams(2, modes)

      if (first < second)
        this.codes[this.codes[this.pointer + 3]] = 1
      else
        this.codes[this.codes[this.pointer + 3]] = 0

      this.pointer += 4
    }

    const equals = (modes) => {
      let [first, second] = getParams(2, modes)

      if (first == second)
        this.codes[this.codes[this.pointer + 3]] = 1
      else
        this.codes[this.codes[this.pointer + 3]] = 0

      this.pointer += 4
    }

    const end = () => {
      this.isComplete = true
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
      let { opCode, modes } = parseInstruction(this.codes[this.pointer])

      let operation = operations[opCode]
      let output = operation(modes)

      if (output != null)
        return output
    } while(!this.isComplete)
  }
}

module.exports = IntCode
