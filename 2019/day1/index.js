const fs = require('fs')
const path = require('path')
const reader = require('readline')

let totalFuel = 0
const requiredFuel = mass => Math.floor(mass / 3) - 2

function totalFuelForModule(mass) {
  let fuel = requiredFuel(mass)
  let additionalFuel = fuel

  while(true) {
    additionalFuel = requiredFuel(additionalFuel)

    if (additionalFuel <= 0)
      break;

      fuel += additionalFuel
  }

  return fuel
}

const lineReader = reader.createInterface({
  input: fs.createReadStream(path.join(__dirname, 'input.txt')),
  terminal: false
})

lineReader.on('line', line => totalFuel += totalFuelForModule(line))
lineReader.on('close', _ => console.log(`totalFuel: ${totalFuel}`))
