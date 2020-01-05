const fs = require('fs')
const path = require('path')

const buffer = fs.readFileSync(path.join(__dirname, 'input.txt'))
const fileContents = buffer.toString().trim()

const pattern = [0, 1, 0, -1]
let signal = fileContents.split('').map(Number)

const expandPattern = (pattern, count) => {
  let result = []

  pattern.forEach(p => {
    for (let i = 0; i < count; i++) {
      result.push(p)
    }
  })

  return result
}

const getPattern = (pattern, index) => pattern[(index + 1) % pattern.length]

const calculatePhase = (signal) =>
  signal.map((_, i) => {
    let offsetPattern = expandPattern(pattern, i + 1)

    let sum = signal
      .map((v, i) => v * getPattern(offsetPattern, i))
      .reduce((acc, v) => acc += v, 0)

    return Number(sum.toString().slice(-1))
  })

const phases = 100

for (let i = 0; i < phases; i++) {
  signal = calculatePhase(signal)
}

console.log(signal.join(''))
