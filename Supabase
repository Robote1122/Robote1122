local Database = require(loadstring(game:HttpGet("https://raw.githubusercontent.com/Robote1122/Robote1122/refs/heads/main/Database.lua"))())
local Types = require(loadstring(game:HttpGet("https://raw.githubusercontent.com/Robote1122/Robote1122/refs/heads/main/Types.d"))())


local Supabase = {}
Supabase.__index = Supabase

function Supabase.createClient(settings: Types.SupabaseClientSettings): Types.SupabaseClient
	return setmetatable({
		connection = Database.connection(settings.url, settings.apiKey),
	}, Supabase)
end

function Supabase:from(name: string): Types.SupabaseClientConnection
	return self.connection:from(name)
end

return Supabase
