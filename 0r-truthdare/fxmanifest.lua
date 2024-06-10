fx_version "cerulean"
lua54 "yes"
game "gta5"
name "0r-truthdare"
author "0Resmon | aliko."
version "1.0.0"
description "Fivem, truth or dare script | 0resmon | aliko.<Discord>"

shared_scripts {
	"@ox_lib/init.lua",
	"shared/**/*"
}

client_scripts {
	"client/utils.lua",
	"client/functions.lua",
	"client/events.lua",
}

server_scripts {
	"server/functions.lua",
	"server/events.lua",
	"server/commands.lua",
}

ui_page "ui/build/index.html"

files {
	"locales/**/*",
	"ui/build/index.html",
	"ui/build/**/*",
}

dependencies {
	"0r_lib"
}

escrow_ignore {
	"client/**/*",
	"locales/**/*",
	"server/**/*",
	"shared/**/*",
}

dependency '/assetpacks'