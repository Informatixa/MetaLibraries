local meta = FindMetaTable("Player")
if not meta then return end

player.Networked = {}

function meta:GetNetworked(name)
	if player.Networked[self:UserID()][name] ~= nil then
		return player.Networked[self:UserID()][name]
	else
		return ""
	end
end

function meta:SetNetworked(name, value)
	player.Networked[self:UserID()][name] = value
end

hook.Add("join", "PlayerNetworkedJoin", function(ply)
	player.Networked[ply:UserID()] = {}
end)
