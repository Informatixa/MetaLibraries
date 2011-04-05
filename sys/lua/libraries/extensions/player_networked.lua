local meta = FindMetaTable("Player")
if not meta then return end

player.Networked = {}

function meta:GetNetworked(name)
	if self:UserID() ~= 0 and player.Networked[self:UserID()] ~= nil and player.Networked[self:UserID()][name] ~= nil then
		return player.Networked[self:UserID()][name]
	else
		return nil
	end
end

function meta:SetNetworked(name, value)
	if self:UserID() ~= 0 and player.Networked[self:UserID()] ~= nil then
		player.Networked[self:UserID()][name] = value
	end
end

hook.Add("join", "PlayerNetworkedJoin", function(ply)
	player.Networked[ply:UserID()] = {}
end)
