const fs = require('fs')
const path = require('path')

const buffer = fs.readFileSync(path.join(__dirname, 'input.txt'))
const fileContents = buffer.toString().trim()

const orbits = fileContents.split('\n').map(orbitStr => {
  let planets = orbitStr.split(')')

  return {
    planet: planets[0],
    star: planets[1],
    weight: 0,
    visited: false
  }
})

const planets = [...new Set(orbits.map(orbit => orbit.star))]

const countOrbits = (planet) => {
  let total = 0

  const directOrbits = orbits.filter(o => o.star == planet)
  total += directOrbits.length

  directOrbits.forEach(directOrbit => {
    total += countOrbits(directOrbit.planet)
  })

  return total
}

let totalOrbits = planets.reduce((acc, planet) => {
  acc += countOrbits(planet)
  return acc
}, 0)

console.log('total orbits', totalOrbits)

const findShortestPath = (source, target) => {
  const paths = new Array()

  const findPath = (source, target, weight) => {
    weight = weight || 0

    const directOrbitsDown = orbits.filter(o => o.star == source && !o.visited)
    const directOrbitsUp = orbits.filter(o => o.planet == source && !o.visited)

    if (directOrbitsDown.some(o => o.planet == target) || directOrbitsUp.some(o => o.star == target)) {
      paths.push(weight - 1)
      return
    }

    directOrbitsDown.forEach(o => {
      o.weight = weight + 1
      o.visited = true
      findPath(o.planet, target, weight + 1)
    })

    directOrbitsUp.forEach(o => {
      o.weight = weight + 1
      o.visited = true
      findPath(o.star, target, weight + 1)
    })
  }

  findPath(source, target)

  return Math.min(paths)
}

console.log('shortest path', findShortestPath('YOU', 'SAN'))
