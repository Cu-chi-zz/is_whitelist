Main = { }
Main.__index = { }
Main.__logger = Logger.Register('Main')

-- @main
AddEventHandler('playerConnecting', function(playerName, setCallback, deferrals)
    local player = source
    local playerId = Whitelist.GetIdentifier(player, 'discord')
    local playerName = Whitelist.GetName(player)
    local playerSteam = Whitelist.GetIdentifier(player, 'steam')

    if not playerId then
        deferrals.done('You need Discord to access the server')
    end

    if not playerSteam then
        deferrals.done('You need Steam to access the server')
    else
        if Whitelist.Check(playerSteam, playerId, playerName) then
            Main.__logger.Log('warning', 'The player '..playerName..', '..playerSteam..' is joining the server')
    
            deferrals.done()
        else
            Main.__logger.Log('error', 'The player '..playerName..', '..playerSteam..' tried to join the server without whitelist')
    
            deferrals.done('You need to do the whitelist to access the server')
        end
    end
end)

-- @threads
Citizen.CreateThread(function()
    Whitelist.Fetch(function(result, count)
        if result then
            table.foreach(result, function(v, k)
                Whitelist.__data[v.identifier] = v
            end)

            Main.__logger.Log('info', ''..count..' whitelisted users have been loaded')
        end
    end)
end)

-- @commands
Core.RegisterCommand('addwh', 'Add a player to the whitelist', {
    { name = 'identifier', help = 'Identifier' },
}, true, function(source, args, player)
    if Whitelist.Add(args[1], player.data.name) then
        Main.__logger.Log('warning', 'Admin '..player.data.name..' added '..args[1]..' to the whitelist')
    end
end, 'mod')

Core.RegisterCommand('removewh', 'Remove a player from the whitelist', {
    { name = 'identifier', help = 'Identificador' },
}, true, function(source, args, player)
    if Whitelist.Remove(args[1]) then
        Main.__logger.Log('warning', 'Admin '..player.data.name..' removed '..args[1]..' to the whitelist')
    end
end, 'mod')

Core.RegisterCommand('refreshwh', 'Refresh the whitelist', {}, false, function(source, args, player)
    Whitelist.__data = { }

    Whitelist.Fetch(function(result, count)
        if result then
            table.foreach(result, function(v, k)
                Whitelist.__data[v.identifier] = v
            end)

            Main.__logger.Log('warning', ''..player.data.name..' refreshed the whitelist')
        end
    end)
end, 'mod')
