fx_version 'cerulean'
game 'gta5'
author 'Bama#1994'

description 'bama-achievements'
version '1.0.0'

shared_scripts {
    'config.lua',
    'shared/*.lua',
}
server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/*.lua',
}
client_scripts {
    'client/*.lua',
}

files {
    'imgs/*.png'
}

lua54 'yes'