const fs = require('fs')
const path = require('path')

const buffer = fs.readFileSync(path.join(__dirname, 'input.txt'))
const fileContents = buffer.toString().trim()
const pixels = fileContents.split('').map(Number)

const width = 25
const height = 6

const chunk = (arr, size) => {
  let result = []

  for (let i=0 , j=arr.length; i < j; i += size) {
      result.push(arr.slice(i,i + size))
  }

  return result
}

const layers = chunk(pixels, width * height)

const fewestZeros = layers
  .map(layer => ({
    zeros: layer.filter(p => p === 0).length,
    ones: layer.filter(p => p === 1).length,
    twos: layer.filter(p => p === 2).length,
  }))
  .sort((a, b) => a.zeros - b.zeros)[0]

console.log('checksum', fewestZeros.ones * fewestZeros.twos)

const renderedPixels = []

for (let i = 0; i < width * height; i++) {
  const layeredPixels = layers.map((layer) => layer[i])

  renderedPixels.push(layeredPixels.find(p => p !== 2))
}

console.log(chunk(renderedPixels, width).join('\n'))
