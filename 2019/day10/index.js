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

const station = asteroids.map(({ x, y }) => {
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

console.log('best station location', station)

let targets = asteroids.map(({ x, y }) => ({
    x,
    y,
    angle: Math.atan2(y - station.y, x - station.x) * (180 / Math.PI),
    distance: Math.hypot(x - station.x, y - station.y)
  })
).sort((a, b) => a.angle - b.angle)

const angles = [...new Set(targets.map(t => t.angle))]
let angleIndex = angles.findIndex(angle => angle == -90)
let targetCount = 0

while (targets.length) {
  const target = targets
    .filter(t => t.angle == angles[angleIndex])
    .sort((a, b) => a.distance - b.distance)[0]

  if (target) {
    targets = targets.filter(({ x, y }) => !(x == target.x && y == target.y))
    targetCount++

    if (targetCount == 200) {
      console.log('200th asteroid checksum', target.x * 100 + target.y)
    }
  }

  angleIndex = angleIndex < angles.length ? angleIndex + 1 : 0
}
