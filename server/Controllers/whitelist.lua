Whitelist = { }
Whitelist.__data = { }
Whitelist.__index = Whitelist
Whitelist.__logger = Logger.RegisterController('Whitelist Controller')

-- @main
Whitelist.Fetch = function(callback)
    local count = 0

    exports.oxmysql:fetch('SELECT * FROM users_whitelist', {}, function(data)
        if data then
            count = #data
        end

        return callback(data, count)
    end)
end

Whitelist.Add = function(identifier, admin)
    if not Whitelist.__data[identifier] then
        exports.oxmysql:execute('INSERT INTO users_whitelist (identifier, admin) VALUES (?, ?)', { identifier, admin })

        return true
    end

    return false
end

Whitelist.Remove = function(identifier)
    if Whitelist.__data[identifier] then
        exports.oxmysql:execute('DELETE FROM users_whitelist WHERE identifier = :identifier', { identifier = identifier })

        return true
    end

    return false
end

Whitelist.UpdateDiscord = function(identifier, discord, name, callback)
    exports.oxmysql:execute('UPDATE users_whitelist SET discord = :discord, name = :name WHERE identifier = :identifier', { discord = discord, name = name, identifier = identifier }, function()
        return callback()
    end)
end

Whitelist.Check = function(identifier, discord, name)
    if Whitelist.__data[identifier] then
        Whitelist.UpdateDiscord(identifier, discord, name, function() end)

        return true
    end

    return false
end

Whitelist.Permissions = function(identifier)
    table.foreach(Settings.admins, function(v, k)
        if identifier == v then
            return true
        end
    end)

    return false
end

Whitelist.GetIdentifier = function(player, type)
    local playerIds = GetPlayerIdentifiers(player)
    local playerId = nil

    for k,v in pairs(playerIds) do
		if string.match(v, type) then
			playerId = v
		end
	end

    return playerId
end

Whitelist.GetName = function(player)
    return GetPlayerName(player)
end