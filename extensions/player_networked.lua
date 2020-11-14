local util = import(METALIBDIR ..'/util.lua')
local mod_hook = import(METALIBDIR ..'/modules/hook.lua')

MetaLibrariesConst.PlayerNetworked = {}

local function pif(public, name, path)
	local private = {}
	private.Player = util.FindMetaTable('Player')

	function private.Player:GetNetworked(name)
		if self:UserID() ~= 0 and MetaLibrariesConst.PlayerNetworked[self:UserID()] ~= nil and MetaLibrariesConst.PlayerNetworked[self:UserID()][name] ~= nil then
			return MetaLibrariesConst.PlayerNetworked[self:UserID()][name]
		else
			return nil
		end
	end

	function private.Player:SetNetworked(name, value)
		if self:UserID() ~= 0 and MetaLibrariesConst.PlayerNetworked[self:UserID()] ~= nil then
			MetaLibrariesConst.PlayerNetworked[self:UserID()][name] = value
		end
	end

	mod_hook.Add('join', 'PlayerNetworkedJoin', function(ply)
		MetaLibrariesConst.PlayerNetworked[ply:UserID()] = {}
	end)
end

return pif