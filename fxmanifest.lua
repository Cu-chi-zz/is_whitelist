fx_version 'cerulean'

game 'gta5'

description 'Whitelist'
author 'ImSnaily'
discord 'Snaily#5452'
version 'v1'

shared_scripts {
    'settings.lua'
}

server_scripts {
    -- @controllers
    'server/Controllers/logger.lua',
    'server/Controllers/table.lua',
    'server/Controllers/whitelist.lua',

    -- @main
    'server/main.lua'
}