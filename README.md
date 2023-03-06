# playdate-template
Template repo for my projects built for the Panic Playdate console.

# Helpful Image processing commands
Useful for making launch images.
- imagemagick - crop and flatten
- `magick .\1.png -crop 350x155+0+0 1.png`
- `magick .\base.png .\mask-on-top.png -layers flatten output.png`
- GIMP - Layers > Transparency > Color-to-Alpha
- gifsicle - optimize gifs recorded from simulator
- `.\gifsicle.exe .\source-gif.gif -O3 -o outputname.gif`