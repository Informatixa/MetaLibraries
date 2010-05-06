ConVar = {}
ConVar.Table = {}

function ConVarExists(name)
	if name == "sv_password" or name == "sv_rcon" or name == "mp_unbuildable" or name == "mp_unbuyable" or name == "mp_reservations" then return true end
	if _game(name) == "" and ConVar.Table[name] == nil then return false end
	return true
end

function CreateConVar(name, value)
	ConVar.Table[name] = value
	
	local function CreateConCommand(cmd, args)
		ConVar.Table[cmd] = args[1]
	end
	table.insert(comcommand.Table, {name = name, func = CreateConCommand})
end

function GetConVarInt(name, default)
	if ConVarExists(name) then
		if ConVar.Table[name] ~= nil then
			return tonumber(ConVar.Table[name])
		else
			return tonumber(_game(name))
		end
	else
		return default or 0
	end
end

function GetConVarBool(name, default)
	if ConVarExists(name) then
		if ConVar.Table[name] ~= nil then
			return tobool(ConVar.Table[name])
		else
			return tobool(_game(name))
		end
	else
		return default or false
	end
end

function GetConVarString(name, default)
	if ConVarExists(name) then
		if ConVar.Table[name] ~= nil then
			return tostring(ConVar.Table[name])
		else
			return tostring(_game(name))
		end
	else
		return default or ""
	end
end

meta = CreateMetaTable("ServerSettings")

function GetConVar(name)
	local var = meta
	var.Name = id
	return var
end

function meta:GetInt()
	return GetConVarInt(self.Name, 0)
end

function meta:GetBool()
	return GetConVarBool(self.Name, false)
end

function meta:GetString(name, default)
	return GetConVarString(self.Name, "")
end

function SinglePlayer()
	return GetConVarBool("sv_lan", false)
end
