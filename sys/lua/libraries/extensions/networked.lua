local meta = FindMetaTable("Player")
if not meta then return end

player.Networked = {}

function meta:GetNetworked(name)
	return player.Networked[self:UserID()][name]
end

function meta:SetNetworked(name, value)
	player.Networked[self:UserID()][name] = value
end

function PlayerJoin(ply)
	player.Networked[ply:UserID()] = {}
end
hook.Add("join", "PlayerNetworkedJoin", PlayerJoin)
