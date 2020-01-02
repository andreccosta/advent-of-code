const fs = require('fs')
const path = require('path')

const buffer = fs.readFileSync(path.join(__dirname, 'input.txt'))
const fileContents = buffer.toString().trim()

const IntCode = require('./intCode')

//let intCode = new IntCode('109,1,204,-1,1001,100,1,100,1008,100,16,101,1006,101,0,99')
// let intCode = new IntCode('1102,34915192,34915192,7,4,7,99,0')
// let intCode = new IntCode('104,1125899906842624,99')
let intCode = new IntCode(fileContents)
intCode.process([1])

console.log(intCode.outputs)
