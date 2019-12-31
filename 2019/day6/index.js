const fs = require('fs')
const path = require('path')

const buffer = fs.readFileSync(path.join(__dirname, 'input.txt'))
const fileContents = buffer.toString().trim()

const orbits = fileContents.split('\n').map(orbitStr => orbitStr.split(')'))
const planets = [...new Set(orbits.map(orbit => orbit[1]))]

const countOrbits = (planet) => {
  let total = 0

  const directOrbits = orbits.filter(o => o[1] == planet)
  total += directOrbits.length

  directOrbits.forEach(directOrbit => {
    total += countOrbits(directOrbit[0])
  })

  return total
}

let totalOrbits = planets.reduce((acc, planet) => {
  acc += countOrbits(planet)
  return acc
}, 0)

console.log(totalOrbits)
