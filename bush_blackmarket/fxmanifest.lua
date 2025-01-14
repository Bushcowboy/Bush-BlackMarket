fx_version 'cerulean'
game 'gta5'

author 'BushCowboy'
description 'Black Market Script for Fivem using ox_inventory, ox_target and ox_lib'
version '1.0'

shared_scripts {
    '@Renewed-Lib/init.lua',
    'config/shared.lua',
    '@ox_lib/init.lua',
}

client_scripts {
	'client/*.lua',
}

server_scripts {
	'server/*.lua'
}

lua54 'yes'
use_experimental_fxv2_oal 'true'