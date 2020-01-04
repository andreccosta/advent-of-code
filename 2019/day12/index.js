const fs = require('fs')
const path = require('path')

const buffer = fs.readFileSync(path.join(__dirname, 'input.txt'))
const fileContents = buffer.toString().trim()

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
  let [_, x, y, z] = /<x=([-]?[0-9]+), y=([-]?[0-9]+), z=([-]?[0-9]+)>/.exec(line).map(Number)
  return new Moon({ x, y, z})
})

const simulate = () => {
  moons.map(moon => {
    moons.map(otherMoon => {
      moon.velocity.x += otherMoon.position.x != moon.position.x ? otherMoon.position.x < moon.position.x ? -1 : 1 : 0;
      moon.velocity.y += otherMoon.position.y != moon.position.y ? otherMoon.position.y < moon.position.y ? -1 : 1 : 0;
      moon.velocity.z += otherMoon.position.z != moon.position.z ? otherMoon.position.z < moon.position.z ? -1 : 1 : 0;
    })
  })

  moons.map(moon => {
    moon.position.x += moon.velocity.x
    moon.position.y += moon.velocity.y
    moon.position.z += moon.velocity.z
  })
}

const steps = 1000

for (let step = 0; step < steps; step++) {
  simulate()
}

let totalEnergy = moons.reduce((acc, moon) => acc += moon.getTotalEnergy() , 0)

console.log(totalEnergy)
