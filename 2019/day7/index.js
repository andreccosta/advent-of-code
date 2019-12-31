const fs = require('fs')
const path = require('path')

const IntCode = require('./intCode')

const buffer = fs.readFileSync(path.join(__dirname, 'input.txt'))
const program = buffer.toString().trim()

const calculateThrusterSignal = (phaseSettings) => {
  let thrusterSignal = 0

  phaseSettings.forEach(phase => {
    let intCode = new IntCode(program)
    thrusterSignal = intCode.process([phase, thrusterSignal])
  })

  return thrusterSignal
}

const getAllPhaseSettings = (digits) => {
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

// let maxThrusterSignal = 0

// getAllPhaseSettings([0,1,2,3,4]).forEach(phaseSettings => {
//   let thrusterSignal = calculateThrusterSignal(phaseSettings)

//   if (thrusterSignal > maxThrusterSignal)
//     maxThrusterSignal = thrusterSignal
// })

// console.log('Max thruster signal', maxThrusterSignal)

class Amplifier {
  constructor() {
    this.intCode = new IntCode(program)
  }

  hasHalted() {
    return this.intCode.isComplete
  }

  run(inputs) {
    return this.intCode.process(inputs)
  }
}

const calculateThrusterSignalLoop = (phaseSettings) => {
  let thrusterSignal = 0
  let end = false

  const amplifiers = phaseSettings.map(phase => {
    let amp = new Amplifier()

    // warm up with phase
    thrusterSignal = amp.run([phase, thrusterSignal])

    return amp
  })

  do {
    amplifiers.forEach(amplifier => {
      if (amplifier.hasHalted()) {
        end = true
        return thrusterSignal
      }

      let amplifierOutput = amplifier.run([thrusterSignal])

      if(amplifierOutput != null)
        thrusterSignal = amplifierOutput
    })
  } while(!end)

  return thrusterSignal
}

let maxThrusterSignal = 0

getAllPhaseSettings([5,6,7,8,9]).forEach(phaseSettings => {
  let thrusterSignal = calculateThrusterSignalLoop(phaseSettings)

  if (thrusterSignal > maxThrusterSignal)
    maxThrusterSignal = thrusterSignal
})

console.log('Max thruster signal with feedback loop', maxThrusterSignal)
