local meta = CreateMetaTable("Player")

player = {}

function player.GetByID(id)
	if id == 0 or not tobool(_player(id, "exists")) then return nil end
	local Table = meta
	Table.ID = id
	return Table
end

function player.GetAll()
	local Table = {}
	for _, v in pairs(_player(0, "table")) do
		table.insert(Table, player.GetByID(v))
	end
	return Table
end

function player.GetByUsgnID(usgn)
	for _, ply in pairs(player.GetAll()) do
		if ply:UsgnID() == usgn then
			return ply
		end
	end
	return nil
end

function player.GetBots()
	local Table = {}
	for _, ply in pairs(player.GetAll()) do
		if ply:IsBot() then
			table.insert(Table, ply)
		end
	end
	return Table
end

function player.GetHumans()
	local Table = {}
	for _, ply in pairs(player.GetAll()) do
		if not ply:IsBot() then
			table.insert(Table, ply)
		end
	end
	return Table
end

function meta:UserID()
	return self.ID
end

function meta:AddDeaths(amount)
	RunConsoleCommand("setdeaths ".. self:UserID() .." ".. (self:Deaths() + amount))
end

function meta:AddScores(amount)
	RunConsoleCommand("setscore ".. self:UserID() .." ".. (self:Scores() + amount))
end

function meta:UsgnID()
	return _player(self:UserID(), "usgn")
end

function meta:Ban()
	if self:UsgnID() == 0 then
		RunConsoleCommand("banip ".. self:UserID() .." ".. self:IPAddress())
	else
		RunConsoleCommand("banusgn ".. self:UserID() .." ".. self:UsgnID())
	end
end

function meta:Kick()
	RunConsoleCommand("kick ".. self:UserID())
end

function meta:Died()
	RunConsoleCommand("deathslap ".. self:UserID())
end

function meta:Died()
	RunConsoleCommand("deathslap ".. self:UserID())
end

function meta:KillSilent()
	RunConsoleCommand("customkill 0 \"\" ".. self:UserID())
end

function meta:SetHealth(amount)
	RunConsoleCommand("sethealth ".. self:UserID() .." ".. amount)
end

function meta:SetArmor(amount)
	RunConsoleCommand("setarmor ".. self:UserID() .." ".. amount)
end

function meta:SetSpeed(amount)
	RunConsoleCommand("speedmod ".. self:UserID() .." ".. amount)
end

function meta:SetMoney(amount)
	RunConsoleCommand("setmoney ".. self:UserID() .." ".. amount)
end

function meta:SetDeaths(amount)
	RunConsoleCommand("setdeaths ".. self:UserID() .." ".. amount)
end

function meta:SetScores(amount)
	RunConsoleCommand("setscore ".. self:UserID() .." ".. amount)
end

function meta:Alive()
	return tobool(self:Health())
end

function meta:Health()
	return _player(self:UserID(), "health")
end

function meta:MaxHealth()
	return _player(self:UserID(), "maxhealth")
end

function meta:Armor()
	return _player(self:UserID(), "armor")
end

function meta:Deaths()
	return _player(self:UserID(), "deaths")
end

function meta:Scores()
	return _player(self:UserID(), "score")
end

function meta:IPAddress()
	return _player(self:UserID(), "ip")
end

function meta:Pos()
	return Vector(_player(self:UserID(), "x"), _player(self:UserID(), "y"))
end

function meta:GetPos()
	return self:Pos()
end

function meta:SetPos(x, y)
	RunConsoleCommand("setpos ".. self:UserID() .." ".. tostring(x) .." ".. tostring(y))
end

function meta:Tile()
	return Vector(_player(self:UserID(), "tilex"), _player(self:UserID(), "tiley"))
end

function meta:GetTile()
	return self:Pos()
end

function meta:SetTile(tilex, tiley)
	local pos = convert.pos(tonumber(tilex), tonumber(tiley))
	RunConsoleCommand("setpos ".. self:UserID() .." ".. tostring(pos.x) .." ".. tostring(pos.y))
end

function meta:Name()
	return _player(self:UserID(), "name")
end

function meta:GetName()
	return self:Name()
end

function meta:SetName(name)
	RunConsoleCommand("setname ".. self:UserID() .." ".. name)
end

function meta:Ping()
	return _player(self:UserID(), "ping")
end

function meta:Speed()
	return _player(self:UserID(), "speedmod")
end

function meta:Money()
	return _player(self:UserID(), "money")
end

function meta:Team()
	return _player(self:UserID(), "team")
end

function meta:SetTeam(team)
	if team == TEAM_TERRORIST then
		RunConsoleCommand("maket ".. self:UserID())
	elseif team == TEAM_COUNTER_TERRORIST then
		RunConsoleCommand("makect ".. self:UserID())
	else
		RunConsoleCommand("makespec ".. self:UserID())
	end
end

function meta:PrintMessage(type, text)
	text = string.replace(text, "@C", "")
	if type == HUD_PRINTCENTER then
		msg2(self:UserID(), text .."@C")
	else
		msg2(self:UserID(), text)
	end
end

function meta:ChatPrint(text)
	msg2(self:UserID(), string.replace(text, "@C", ""))
end

function meta:Hud(id, txt, pos, align)
	RunConsoleCommand("hudtxt2 ".. self:UserID() .." ".. id .." \"".. txt .."\" ".. pos.x .." ".. pos.y .." ".. align)
end

function meta:ClearHud(id)
	RunConsoleCommand("hudtxt2 ".. self:UserID() .." ".. id .." \"\" 0 0 0")
end

function meta:IsBot()
	return tobool(_player(self:UserID(), "bot"))
end

function meta:IsPlayer()
	return not self:IsBot()
end

function meta:IsListenServerHost()
	if self:IPAddress() == "0.0.0.0" then return true end
	if self:IPAddress() == "127.0.0.1" then return true end
	if string.find(self:IPAddress(), "192.168.[^*].[^*]") ~= nil then return true end
	return false
end

function meta:GetWeapon()
	if self:Alive() then
		return weapon.GetByType(_player(self:UserID(), "weapontype"))
	else
		return nil
	end
end

--[[function meta:GetWeapons()
	local Table = {}
	if self:Alive() then
		for _, v in pairs(playerweapons(self:UserID())) do
			table.insert(Table, weapon.GetByType(v))
		end
	end
	return Table
end]]
