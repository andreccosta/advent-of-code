const fs = require('fs')
const path = require('path')

const buffer = fs.readFileSync(path.join(__dirname, 'input.txt'))
const fileContents = buffer.toString().trim()

const IntCode = require('./intCode')

let intCode = new IntCode(fileContents)
intCode.process([2])

console.log(intCode.outputs)
