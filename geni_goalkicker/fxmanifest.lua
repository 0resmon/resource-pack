fx_version 'cerulean'
game 'gta5'
lua54 'yes'
shared_scripts {
	'shared/locale.lua',
	'shared/cores.lua',
	'locales/en.lua',
	'locales/*.lua',
	'shared/config.lua'
}
escrow_ignore {
	'server/*.lua',
	'client/*.lua',
	'shared/*.lua',
	'locales/*.lua'
}
client_scripts {
	'client/*.lua'
}
server_scripts {
    '@oxmysql/lib/MySQL.lua',
	'shared/config_sv.lua',
    'server/*.lua'
}
ui_page 'html/index.html'
files {
	'html/*.html',
	'html/style.css',
	'html/index.js',
    'html/files/*.png',
	'html/files/*.jpg',
	'html/files/*.webp',
	'html/files/*.svg',
	'html/fonts/*.ttf'
}
dependency '/assetpacks'