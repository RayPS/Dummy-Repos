const Jimp = require('jimp')

function bg(input, output) {

  let width = 3 * 375
  let height = 3 * 667
  let padding = 3 * 24
  let quality = 60

  Jimp.read(input, (err, image) => {

    if (err) {
      new Jimp(100, 100, 'black').write(output)
      console.log(err)
      return
    }
  
    let source = image
      .resize(width - padding * 2, Jimp.AUTO)
  
    let background = image
      .clone()
      .resize(1, 2, Jimp.RESIZE_BICUBIC)
      .color([{ apply: 'darken', params: [10] }])
      .resize(width, height, Jimp.RESIZE_BILINEAR)
  
    let centerY = (height - source.bitmap.height) / 2
  
    let shadow = new Jimp(source.bitmap.width, source.bitmap.height, 'black')
    
    background
      .composite(shadow, padding, centerY, { opacitySource: 0.1 })
      .blur(50)
      .composite(source, padding, centerY)
      .quality(quality)
      .write(output)
  }) 
}

for (let i of Array(5).keys()) {
  bg(`${i+1}.jpeg`, `${i+1}-output.jpg`)
}

