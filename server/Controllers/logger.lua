Logger = { }
Logger.__registers = { }
Logger.__controllers = { }
Logger.__colors = { ['info'] = '7', ['error'] = '1', ['warning'] = '3' }
Logger.__index = Logger

-- @main
Logger.Register = function(name)
    local this = {}

    this.name = name

    if not Logger.__registers[this.name] then
        Logger.__registers[this.name] = true
    end

    -- @functions
    this.Log = function(type, message)
        if Logger.__registers[this.name] then
            Citizen.Trace('^4['..os.date('%c')..'] ^2['..this.name..'] ^'..Logger.__colors[type]..'['..type:upper()..'] '..message..' \n')
        end
    end

    return this
end

Logger.RegisterController = function(name)
    Logger.__controllers[name] = true

    if Logger.__controllers[name] then
        local Register = Logger.Register(name)

        Register.Log('info', 'has been loaded correctly')
    else
        Register.Log('error', 'has not loaded correctly')
    end
end