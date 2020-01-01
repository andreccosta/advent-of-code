const fs = require('fs')
const path = require('path')

const buffer = fs.readFileSync(path.join(__dirname, 'input.txt'))
const fileContents = buffer.toString().trim()
const pixels = fileContents.split('').map(Number)

const width = 25
const height = 6

const layers = [];

for (let x = 0; x < fileContents.length; x += width * height) {
  layers.push(pixels.slice(x, x + width * height));
}

const fewestZeros = layers
  .map(layer => ({
    zeros: layer.filter(p => p === 0).length,
    ones: layer.filter(p => p === 1).length,
    twos: layer.filter(p => p === 2).length,
  }))
  .sort((a, b) => a.zeros - b.zeros)[0]

console.log('checksum', fewestZeros.ones * fewestZeros.twos)
