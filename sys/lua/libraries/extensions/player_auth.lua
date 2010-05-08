local meta = FindMetaTable("Player")
if not meta then return end

function meta:IsUserGroup(name)
	return self:GetNetworked("UserGroup") == name
end

function meta:IsSuperAdmin()
	return self:IsUserGroup("superadmin")
end

function meta:IsAdmin()
	if self:IsSuperAdmin() then return true end
	if self:IsUserGroup("admin") then return true end
	return false
end

function meta:SetUserGroup(name)
	self:SetNetworked("UserGroup", name)
end

Admins = {}

if file.Exists("../users.txt") then
	for line in file.Lines("../users.txt") do
		line = string.replace(line, " ", "")
		line = string.replace(line, "\t", "")
		if line:sub(1, 2) ~= "//" and string.find(line, "#") ~= nil then
			local exps = string.explode(":", line:sub(2))
			local id = tonumber(exps[3])
			Admins[id] = {}
			Admins[id].name = exps[2]
			Admins[id].group = exps[1]:sub(2)
		end
	end
end

function PlayerSpawn(ply)
	local usgnid = ply:UsgnID()
	local ipaddress = ply:IPAddress()
	
	if SinglePlayer() or ply:IsListenServerHost() then
		ply:SetUserGroup("superadmin")
		return
	end
	
	if Admins[usgnid] == nil and Admins[ipaddress] == nil then
		ply:SetUserGroup("user")
		return
	end
	
	local admin = Admins[usgnid]
	if admin == nil then
		admin = Admins[ipaddress]
	end
	
	ply:SetUserGroup(admin.group)
	ply:PrintMessage(HUD_PRINTTALK, "Hey '".. admin.name .."' - You're in the '".. admin.group .."' group on this server.")
end
hook.Add("join", "PlayerAuthSpawn", PlayerSpawn)
