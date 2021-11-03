Table = { }
Table.__index = { }
Table.__logger = Logger.RegisterController('Table Controller')

-- @main
table.foreach = function(t, func)
	for k, v in pairs(t) do
		func(v ,k)
	end
end