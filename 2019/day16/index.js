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

// for (let i = 0; i < phases; i++) {
//   signal = calculatePhase(signal)
// }

// console.log(signal.slice(messageIndex, messageIndex + 8))
// console.log(signal.join(''))

const messageOffset = Number(fileContents.slice(0, 7))
signal = fileContents
  .repeat(10000)
  .split('')
  .map(Number)
  .slice(messageOffset)

  for (let p = 0; p < phases; p++) {
    for (let i = signal.length - 1; i >= 0; i--) {
      signal[i] = ((signal[i + 1] || 0) + signal[i]) % 10
    }
  }

console.log(signal.slice(0, 8).join(''))
