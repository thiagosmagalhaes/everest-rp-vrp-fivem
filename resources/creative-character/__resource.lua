resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

ui_page "character-nui/index.html"

files {
	"character-nui/index.html",
	"character-nui/range.png",
	"character-nui/style.css",
	"character-nui/vue.js"
}

client_scripts {
	"@vrp/lib/utils.lua",
	"client.lua"
}

server_scripts {
	"@vrp/lib/utils.lua",
	"server.lua"
}