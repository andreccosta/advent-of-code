const fs = require('fs')
const path = require('path')

const buffer = fs.readFileSync(path.join(__dirname, 'input.txt'))
const fileContents = buffer.toString().trim()

const asteroidsMap = fileContents.split('\n').map(r => r.split(''))
const asteroids = []

asteroidsMap.forEach((row, y) =>
  row.forEach((v, x) => {
    if (v == '#')
      asteroids.push({ x, y })
  })
)

const result = asteroids.map(({ x, y }) => {
  const angles = new Set()

  asteroids.forEach(({ x: z, y: w }) => {
    if (x !== z || y !== w) {
      angles.add(Math.atan2(w - y, z - x))
    }
  })

  return {
    asteroids: angles.size,
    x,
    y
  }
}).sort((x, y) => y.asteroids - x.asteroids)[0]

console.log(result)
