const fs = require('fs')
const path = require('path')

const IntCode = require('./intCode')

const buffer = fs.readFileSync(path.join(__dirname, 'input.txt'))
const program = buffer.toString().trim()

const calculateThrusterSignal = (phaseSettings) => {
  let thrusterSignal = 0

  phaseSettings.forEach(phase => {
    let intCode = new IntCode([phase, thrusterSignal])
    let outputs = intCode.process(program)

    thrusterSignal = outputs[0]
  })

  return thrusterSignal
}

const getAllPhaseSettings = () => {
  const digits = [0,1,2,3,4]
  let permutations = []
  let usedChars = []

  const permute = (input) => {
    for (let i = 0; i < input.length; i++) {
      let ch = input.splice(i, 1)[0];
      usedChars.push(ch);

      if (input.length == 0)
        permutations.push([...usedChars]);

      permute(input);
      input.splice(i, 0, ch);
      usedChars.pop();
    }

    return permutations
  }

  return permute(digits)
}

let maxThrusterSignal = 0

getAllPhaseSettings().forEach(phaseSettings => {
  let thrusterSignal = calculateThrusterSignal(phaseSettings)

  if (thrusterSignal > maxThrusterSignal)
    maxThrusterSignal = thrusterSignal
})

console.log('Max thruster signal', maxThrusterSignal)
