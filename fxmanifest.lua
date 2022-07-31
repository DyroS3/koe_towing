fx_version 'adamant'

game 'gta5'

version '1.0.0'
lua54 'yes'

client_scripts {
	'client.lua',
	'config.lua'
 }
 
 server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server.lua',
	'config.lua'
 }
 files {
	'/ox_inventory/web/build/images/*.png',
}
 shared_script '@ox_lib/init.lua'