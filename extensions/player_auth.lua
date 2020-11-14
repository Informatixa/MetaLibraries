local util = import(METALIBDIR ..'/util.lua')
local mod_hook = import(METALIBDIR ..'/modules/hook.lua')
local mod_file = import(METALIBDIR ..'/modules/file.lua')
local ext_string = import(METALIBDIR ..'/extensions/string.lua')
local ext_player_networked = import(METALIBDIR ..'/extensions/player_networked.lua')

MetaLibrariesConst.Admins = {}

if mod_file.Exists(SYSDIR ..'/users.txt') then
	for line in mod_file.Lines(SYSDIR ..'/users.txt') do
		line = ext_string.trim(line)
		if not empty(line) then
			if string.len(line) > 2 and line:sub(1, 2) ~= '//' and line:sub(1, 1) ~= '#' then
				local exps = ext_string.split(':', line)
				local id = tonumber(exps[3])
				Admins[id] = {}
				Admins[id].name = exps[2]
				Admins[id].group = exps[1]
			end
		end
	end
end

local function pif(public, name, path)
	local private = {}
	private.Player = util.FindMetaTable('Player')
	
	function private.Player:IsUserGroup(name)
		return self:GetNetworked('UserGroup') == name
	end

	function private.Player:IsSuperAdmin()
		return self:IsUserGroup('superadmin')
	end

	function private.Player:IsAdmin()
		if self:IsSuperAdmin() then return true end
		if self:IsUserGroup('admin') then return true end
		return false
	end

	function private.Player:SetUserGroup(name)
		self:SetNetworked('UserGroup', name)
	end

	mod_hook.Add('join', 'PlayerAuthJoin', function(ply)
		local usgnid = ply:UsgnID()
		local ipaddress = ply:IPAddress()
		
		if SinglePlayer() or ply:IsListenServerHost() then
			ply:SetUserGroup('superadmin')
			ply:ChatPrint('Hey \''.. ply:Name() ..'\' - You\'re in the \'superadmin\' group on this server.')
			return
		end
		
		if MetaLibrariesConst.Admins[usgnid] == nil and MetaLibrariesConst.Admins[ipaddress] == nil then
			ply:SetUserGroup('user')
			return
		end
		
		local admin = MetaLibrariesConst.Admins[usgnid]
		if admin == nil then
			admin = MetaLibrariesConst.Admins[ipaddress]
		end
		
		ply:SetUserGroup(admin.group)
		ply:ChatPrint('Hey \''.. admin.name ..'\' - You\'re in the \''.. admin.group ..'\' group on this server.')
	end)
end

return pif
