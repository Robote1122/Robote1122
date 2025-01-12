local Table = loadstring(game:HttpGet("https://raw.githubusercontent.com/Robote1122/Robote1122/refs/heads/main/Table"))()

local Database = {}
Database.__index = Database

function Database.connection(url, apiKey)
	return setmetatable({
		db = {
			url = url,
			apiKey = apiKey,
		},
	}, Database)
end

function Database:from(name: string)
	return Table.new(name, self.db)
end

return Database
