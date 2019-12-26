const fs = require('fs')
const path = require('path')

const buffer = fs.readFileSync(path.join(__dirname, 'input.txt'))
const fileContents = buffer.toString().trim()

const lines = fileContents.split('\n').map(line => line.split(','))
const coordinates = []

const repeatMove = (move, point, count) => {
  let points = []

  for (let i = 0; i < count; i++) {
    switch (move) {
      case 'R':
        point.x += 1
        break
      case 'U':
        point.y += 1
        break
      case 'L':
        point.x -= 1
        break
      case 'D':
        point.y -= 1
        break
    }

    points.push({ ...point })
  }

  return points
}

lines.forEach(line => {
  let position = { x: 0, y: 0 }
  let positions = []

  line.forEach(move => {
    let coords = repeatMove(move[0], position, move.slice(1, move.length))
    positions.push(...coords)
    position = coords[coords.length - 1]
  })

  coordinates.push(positions)
})

const firstLine = coordinates[0]
const secondLine = coordinates[1]

const intercepts = firstLine.filter(firstPos =>
  secondLine.some(secondPos =>
    secondPos.x === firstPos.x && secondPos.y === firstPos.y
  )
)

const minDistance = intercepts.reduce((min, position) => {
  const sum = Math.abs(position.x) + Math.abs(position.y)
  return sum < min ? sum : min
}, Number.MAX_VALUE)

console.log('min distance', minDistance)

const minSteps = intercepts.reduce((min, position) => {
  const matchPosition = p => p.x === position.x && p.y === position.y
  const sum = firstLine.findIndex(matchPosition) + secondLine.findIndex(matchPosition) + 2

  return sum < min ? sum : min
}, Number.MAX_VALUE)

console.log('min steps', minSteps)
