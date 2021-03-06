const fs = require('fs')
const path = require('path')

const buffer = fs.readFileSync(path.join(__dirname, 'input.txt'))
const fileContents = buffer.toString().trim()

const gcd = (a, b) => !b ? a : gcd(b, a % b)
const lcm = (a, b) => a * (b / gcd(a, b))

class Moon {
  constructor(position) {
    this.position = position
    this.velocity = { x: 0, y: 0, z: 0 }
  }

  getPotentialEnergy = () =>
    Math.abs(this.position.x) + Math.abs(this.position.y) + Math.abs(this.position.z)

  getKineticEnergy = () =>
    Math.abs(this.velocity.x) + Math.abs(this.velocity.y) + Math.abs(this.velocity.z)

  getTotalEnergy = () =>
    this.getPotentialEnergy() * this.getKineticEnergy()
}

let moons = fileContents.split('\n').map(line => {
  let [x, y, z] = line.match(/(-?\d+)/g).map(Number)
  return new Moon({ x, y, z })
})

const simulate = () => {
  moons.map(moon => {
    moons.map(otherMoon => {
      moon.velocity.x += otherMoon.position.x != moon.position.x ? otherMoon.position.x < moon.position.x ? -1 : 1 : 0
      moon.velocity.y += otherMoon.position.y != moon.position.y ? otherMoon.position.y < moon.position.y ? -1 : 1 : 0
      moon.velocity.z += otherMoon.position.z != moon.position.z ? otherMoon.position.z < moon.position.z ? -1 : 1 : 0
    })
  })

  moons.map(moon => {
    moon.position.x += moon.velocity.x
    moon.position.y += moon.velocity.y
    moon.position.z += moon.velocity.z
  })
}

const simulateAxis = (axis) => {
  moons.map(moon => {
    moons.map(otherMoon => {
      moon.velocity[axis] += otherMoon.position[axis] != moon.position[axis] ? otherMoon.position[axis] < moon.position[axis] ? -1 : 1 : 0
    })
  })

  moons.map(moon => {
    moon.position[axis] += moon.velocity[axis]
  })
}

const steps = 1000

for (let step = 0; step < steps; step++) {
  simulate()
}

let totalEnergy = moons.reduce((acc, moon) => acc += moon.getTotalEnergy() , 0)

console.log(totalEnergy)

const getAxisState = (moons, axis) => {
  return moons.map(moon => ({ position: moon.position[axis], velocity: moon.velocity[axis] }))
}

const compareAxisState = (firstState, secondState) => {
  return firstState.every((mfs, i) => {
    let mss = secondState[i]

    return mfs.position == mss.position && mfs.velocity == mss.velocity
  })
}

const axes = ['x', 'y', 'z']
const stepsAxis = new Map()

axes.map(axis => {
  let axisDone = false
  let count = 0

  let initialState = getAxisState(moons, axis)

  do {
    simulateAxis(axis)
    count++

    axisDone = compareAxisState(initialState, getAxisState(moons, axis))
  } while (!axisDone)

  stepsAxis.set(axis, count)
})

console.log(lcm(lcm(stepsAxis.get('x'), stepsAxis.get('y')), stepsAxis.get('z')))
