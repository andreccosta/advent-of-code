const fs = require('fs')
const path = require('path')

const IntCode = require('./intCode')

const buffer = fs.readFileSync(path.join(__dirname, 'input.txt'))
const fileContents = buffer.toString().trim()

const robot = { position: { x: 0, y: 0 }, direction: 'u'}
const directions = ['u', 'r', 'd', 'l']
const intCode = new IntCode(fileContents)
const panels = new Map()

intCode.process([1])

while(intCode.outputs && intCode.outputs.length > 0) {
  const turn = intCode.outputs[1] === 0 ? 'l' : 'r'

  if (panels.get(`${robot.position.x},${robot.position.y}`) || 0 != intCode.outputs[0]) {
    panels.set(`${robot.position.x},${robot.position.y}`, intCode.outputs[0])
  }

  robot.direction = turn === 'r' ?
    directions[(directions.indexOf(robot.direction) + 1) % directions.length] :
    directions[(directions.indexOf(robot.direction) - 1 < 0 ? directions.indexOf(robot.direction) + directions.length - 1: directions.indexOf(robot.direction) - 1)]

  switch (robot.direction) {
    case 'u':
      robot.position.y--
      break
    case 'd':
      robot.position.y++
      break
    case 'r':
      robot.position.x++
      break
    case 'l':
      robot.position.x--
      break
  }

  const panel = panels.get(`${robot.position.x},${robot.position.y}`) || 0

  intCode.clear()
  intCode.process([panel])
}

console.log('total panels', panels.size)

const coords = [...panels.keys()]
const { width, height } = coords.reduce((acc, coord) => {
  const [x, y] = coord.split(',').map(Number)

  return { width: Math.max(acc.width, x), height: Math.max(acc.height, y)}
}, { width: 0, height: 0 })

const hull = Array.from(Array(height + 1), () => new Array(width + 1).fill(' '))

coords.map(coord => {
  const [x, y] = coord.split(',').map(Number)
  hull[y][x] = panels.get(coord) === 1 ? '█' : ' '
})

hull.map(r => {
  console.log(r.join(''))
})
