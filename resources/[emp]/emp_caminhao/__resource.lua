resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

server_scripts {
	"@vrp/lib/utils.lua",
	"server.lua"
}

ui_page "nui/ui.html"

client_scripts {
	"@vrp/lib/utils.lua",
	"client.lua"
}

files {
	"nui/ui.html",
	"nui/ui.js",
	"nui/ui.css"
}