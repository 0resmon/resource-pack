fx_version 'bodacious'

version '0.0.0'

games { 'gta5' }


ui_page 'html/index.html'
files {
  'html/index.html',
  'html/script.js',
  'html/style.css',
  'html/*otf',
  'html/*png',
  'html/*mp3',
  'html/*wav',
  'html/*ttf',
  'images/*.png',
  'images/*.jpg',
  'images/*.webp',
  'images/*.mp4',
  'images/*.svg',
  'fonts/*.ttf',
  'fonts/*.otf'
 
}

client_scripts{
    'client/client.lua',
    'config.lua'
}

escrow_ignore {
  'config.lua',
  'client/client.lua',
}

lua54 "yes"

dependency '/assetpacks'