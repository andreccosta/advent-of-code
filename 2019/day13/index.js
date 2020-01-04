const fs = require('fs')
const path = require('path')

const IntCode = require('./intCode')

const buffer = fs.readFileSync(path.join(__dirname, 'input.txt'))
let fileContents = buffer.toString().trim()

fileContents = '2' + fileContents.substring(1)

const intCode = new IntCode(fileContents)

let score = 0
let ballPosition = 0
let paddlePosition = 0

const display = (content) => {
  const displayArr = Array.from(new Array(20), () => new Array(19).fill(' '))

  for (let i = 0; i < content.length; i += 3) {
    let x = content[i]
    let y = content[i + 1]
    let tileId = content[i + 2]

    if (x == -1 && y == 0) {
      score = tileId
      continue
    }

    switch (tileId) {
      case 0:
        displayArr[y][x] = ' '
        break
      case 1:
        displayArr[y][x] = '|'
        break
      case 2:
        displayArr[y][x] = '█'
        break
      case 3:
        paddlePosition = x
        displayArr[y][x] = '_'
        break
      case 4:
        ballPosition = x
        displayArr[y][x] = 'o'
        break
    }
  }

  console.log('score', score)
  displayArr.map(r => console.log(r.join('')))
}

let input = 0

do {
  intCode.process(input)
  display(intCode.outputs)

  input = ballPosition == paddlePosition ? 0 : ballPosition < paddlePosition ? -1 : 1;

  intCode.continue()
} while(!intCode.isDone)

console.log('final score', score)
