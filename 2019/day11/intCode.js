class IntCode {
  isDone = false
  pointer = 0
  relativeBase = 0
  outputs = []

  constructor(program) {
    this.codes = program.split(',').map(code => Number(code))
  }

  clear() {
    this.outputs = []
    this.isDone = false
  }

  process(inputs) {
    let inputsPointer = 0

    if(this.isDone)
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
      mode = mode || 0

      if (mode === 2) {
        return this.codes[this.relativeBase + this.codes[index]] || 0
      }

      if (mode === 1) {
        return this.codes[index] || 0
      }

      if (mode === 0) {
        return this.codes[this.codes[index]] || 0
      }

      throw new Error('Invalid param mode', mode)
    }

    const getParams = (count, modes) => {
      let parameters = []

      for (let i = 0; i < count; i++) {
        parameters.push(getParam(modes[i], this.pointer + i + 1))
      }

      return parameters
    }

    const getOutIndex = (relIndex, modes) => {
      let mode = modes[relIndex - 1] || 0

      if (mode === 2) {
        return this.relativeBase + this.codes[this.pointer + relIndex] || 0
      }

      if (mode === 1) {
        return this.pointer + relIndex
      }

      if (mode === 0) {
        return this.codes[this.pointer + relIndex] || 0
      }

      throw new Error('Invalid param mode', mode)
    }

    const add = (modes) => {
      let [first, second] = getParams(2, modes)
      let outIndex = getOutIndex(3, modes)

      this.codes[outIndex] = first + second
      this.pointer += 4
    }

    const multiply = (modes) => {
      let [first, second] = getParams(2, modes)
      let outIndex = getOutIndex(3, modes)

      this.codes[outIndex] = first * second
      this.pointer += 4
    }

    const read = (modes) => {
      let outputIndex = getOutIndex(1, modes)

      this.codes[outputIndex] = inputs[inputsPointer++]
      this.pointer += 2
    }

    const output = (modes) => {
      let [first] = getParams(1, modes)

      this.outputs.push(first)
      this.pointer += 2

      if (this.outputs.length == 2)
        this.isDone = true
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

      if (first == 0)
        this.pointer = second
      else
        this.pointer += 3
    }

    const lessThan = (modes) => {
      let [first, second] = getParams(2, modes)
      let outIndex = getOutIndex(3, modes)

      if (first < second)
        this.codes[outIndex] = 1
      else
        this.codes[outIndex] = 0

      this.pointer += 4
    }

    const equals = (modes) => {
      let [first, second] = getParams(2, modes)
      let outIndex = getOutIndex(3, modes)

      if (first == second)
        this.codes[outIndex] = 1
      else
        this.codes[outIndex] = 0

      this.pointer += 4
    }

    const adjustRelativeBase = (modes) => {
      let [first] = getParams(1, modes)

      this.relativeBase += first
      this.pointer += 2
    }

    const end = () => {
      this.isDone = true
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
      9: adjustRelativeBase,
      99: end
    }

    do {
      let { opCode, modes } = parseInstruction(this.codes[this.pointer])

      operations[opCode](modes)
    } while(!this.isDone)
  }
}

module.exports = IntCode
