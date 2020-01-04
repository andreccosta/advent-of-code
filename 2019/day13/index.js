const fs = require('fs')
const path = require('path')

const IntCode = require('./intCode')

const buffer = fs.readFileSync(path.join(__dirname, 'input.txt'))
const fileContents = buffer.toString().trim()

const intCode = new IntCode(fileContents)

intCode.process()

let count = 0

for (let i = 0; i < intCode.outputs.length; i += 3) {
  if (intCode.outputs[i + 2] == 2)
    count++
}

console.log(count)
