resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

ui_page 'html/index.html'

client_scripts {
	"@vrp/lib/utils.lua",
	"client.lua"
}

server_scripts {
	"@vrp/lib/utils.lua",
	"server.lua"
}

files {
	'html/index.html',
	'html/atmtest.1.css',
	'html/js/index.js',
	'html/css/atm.css',
	'html/css/style.css',
}
 