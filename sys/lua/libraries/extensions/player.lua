local meta = CreateMetaTable("Player")

player = {}

function player.GetByID(id)
	if id == 0 or not tobool(_player(id, "exists")) then return nil end
	local Table = CopyMetaTable("Player")
	Table.ID = id
	return Table
end

function player.Rcon(id, ip, port)
	local Table = CopyMetaTable("Player")
	Table.ID = id
	Table.IP = ip
	Table.Port = port
	return Table
end

function player.GetAll()
	local players = {}
	for _, v in pairs(_player(0, "table")) do
		table.insert(players, player.GetByID(v))
	end
	return players
end

function player.GetAllLiving()
	local players = {}
	for _, v in pairs(_player(0, "tableliving")) do
		table.insert(players, player.GetByID(v))
	end
	return players
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
	local bots = {}
	for _, ply in pairs(player.GetAll()) do
		if ply:IsBot() then
			table.insert(bots, ply)
		end
	end
	return bots
end

function player.GetBotsLiving()
	local bots = {}
	for _, ply in pairs(player.GetAllLiving()) do
		if ply:IsBot() then
			table.insert(bots, ply)
		end
	end
	return bots
end

function player.GetHumansLiving()
	local players = {}
	for _, ply in pairs(player.GetAllLiving()) do
		if not ply:IsBot() then
			table.insert(players, ply)
		end
	end
	return players
end

function player.GetHumans()
	local players = {}
	for _, ply in pairs(player.GetAll()) do
		if not ply:IsBot() then
			table.insert(players, ply)
		end
	end
	return players
end

function player.UnBan(text)
	RunConsoleCommand("unban ".. text)
end

function meta:UserID()
	return self.ID
end

function meta:AddDeaths(amount)
	if self:UserID() ~= 0 then
		RunConsoleCommand("setdeaths ".. self:UserID() .." ".. (self:Deaths() + amount))
	end
end

function meta:AddScores(amount)
	if self:UserID() ~= 0 then
		RunConsoleCommand("setscore ".. self:UserID() .." ".. (self:Scores() + amount))
	end
end

function meta:UsgnID()
	if self:UserID() == 0 then
		return 0
	else
		return _player(self:UserID(), "usgn")
	end
end

function meta:Ban()
	if self:UsgnID() == 0 then
		RunConsoleCommand("banip ".. self:IPAddress())
	else
		RunConsoleCommand("banusgn ".. self:UsgnID())
	end
end

function meta:BanName()
	if self:UserID() ~= 0 then
		RunConsoleCommand("banname ".. self:Name())
	end
end

function meta:Kick(reason)
	if self:UserID() ~= 0 then
		if empty(reason) then
			RunConsoleCommand("kick ".. self:UserID())
		else
			RunConsoleCommand("kick ".. self:UserID() .."\"".. reason .."\"")
		end
	end
end

function meta:Kill(killer, wpn)
	if self:UserID() ~= 0 and self:Alive() then
		if empty(killer) or empty(player.GetByID(killer:UserID())) then killer = 0 else killer = killer:UserID() end
		if empty(wpn) or empty(weapon.GetByType(wpn:Type())) then
			wpn = weapon.GetByType(ITEM_KNIFE):Name() 
		else
			if type(wpn) ~= "string" then
				wpn = wpn:Name()
			end
		end
		RunConsoleCommand("customkill ".. killer .." \"".. wpn .."\" ".. self:UserID())
	end
end

function meta:Die()
	if self:UserID() ~= 0 and self:Alive() then
		RunConsoleCommand("killplayer ".. self:UserID())
	end
end

function meta:SetHealth(amount)
	if self:UserID() ~= 0 then
		RunConsoleCommand("sethealth ".. self:UserID() .." ".. amount)
	end
end

function meta:SetArmor(amount)
	if self:UserID() ~= 0 then
		RunConsoleCommand("setarmor ".. self:UserID() .." ".. amount)
	end
end

function meta:SetSpeed(amount)
	if self:UserID() ~= 0 then
		RunConsoleCommand("speedmod ".. self:UserID() .." ".. amount)
	end
end

function meta:SetMoney(amount)
	if self:UserID() ~= 0 then
		RunConsoleCommand("setmoney ".. self:UserID() .." ".. amount)
	end
end

function meta:SetDeaths(amount)
	if self:UserID() ~= 0 then
		RunConsoleCommand("setdeaths ".. self:UserID() .." ".. amount)
	end
end

function meta:SetScores(amount)
	if self:UserID() ~= 0 then
		RunConsoleCommand("setscore ".. self:UserID() .." ".. amount)
	end
end

function meta:Alive()
	if self:UserID() == 0 then
		return 0
	else
		return tobool(self:Health())
	end
end

function meta:Health()
	if self:UserID() == 0 then
		return 0
	else
		return _player(self:UserID(), "health")
	end
end

function meta:MaxHealth()
	if self:UserID() == 0 then
		return 0
	else
		return _player(self:UserID(), "maxhealth")
	end
end

function meta:Armor()
	if self:UserID() == 0 then
		return 0
	else
		return _player(self:UserID(), "armor")
	end
end

function meta:Deaths()
	if self:UserID() == 0 then
		return 0
	else
		return _player(self:UserID(), "deaths")
	end
end

function meta:Scores()
	if self:UserID() == 0 then
		return 0
	else
		return _player(self:UserID(), "score")
	end
end

function meta:IPAddress()
	if self:UserID() == 0 then
		return self.IP
	else
		return _player(self:UserID(), "ip")
	end
end

function meta:Pos()
	if self:UserID() == 0 then
		return Vector(0, 0)
	else
		return Vector(_player(self:UserID(), "x"), _player(self:UserID(), "y"))
	end
end

function meta:GetPos()
	return self:Pos()
end

function meta:SetPos(x, y)
	if self:UserID() ~= 0 then
		RunConsoleCommand("setpos ".. self:UserID() .." ".. tostring(x) .." ".. tostring(y))
	end
end

function meta:Tile()
	if self:UserID() == 0 then
		return Vector(0, 0)
	else
		return Vector(_player(self:UserID(), "tilex"), _player(self:UserID(), "tiley"))
	end
end

function meta:GetTile()
	return self:Tile()
end

function meta:SetTile(tilex, tiley)
	if self:UserID() ~= 0 then
		local pos = convert.pos(tonumber(tilex), tonumber(tiley))
		RunConsoleCommand("setpos ".. self:UserID() .." ".. tostring(pos.x) .." ".. tostring(pos.y))
	end
end

function meta:Name()
	if self:UserID() == 0 then
		return "Rcon"
	else
		return _player(self:UserID(), "name")
	end
end

function meta:GetName()
	return self:Name()
end

function meta:SetName(name)
	if self:UserID() ~= 0 then
		RunConsoleCommand("setname ".. self:UserID() .." ".. name)
	end
end

function meta:Ping()
	if self:UserID() == 0 then
		return 0
	else
		return _player(self:UserID(), "ping")
	end
end

function meta:Speed()
	if self:UserID() == 0 then
		return 0
	else
		return _player(self:UserID(), "speedmod")
	end
end

function meta:Money()
	if self:UserID() == 0 then
		return 0
	else
		return _player(self:UserID(), "money")
	end
end

function meta:Team()
	if self:UserID() == 0 then
		return 0
	else
		return _player(self:UserID(), "team")
	end
end

function meta:SetTeam(team)
	if self:UserID() ~= 0 then
		if team == TEAM_TERRORIST then
			RunConsoleCommand("maket ".. self:UserID())
		elseif team == TEAM_COUNTER_TERRORIST then
			RunConsoleCommand("makect ".. self:UserID())
		else
			RunConsoleCommand("makespec ".. self:UserID())
		end
	end
end

function meta:PrintMessage(type, text)
	if self:UserID() ~= 0 then
		text = string.replace(text, "@C", "")
		if type == HUD_PRINTCENTER then
			msg2(self:UserID(), text .."@C")
		else
			msg2(self:UserID(), text)
		end
	end
end

function meta:ChatPrint(text)
	if self:UserID() ~= 0 then
		msg2(self:UserID(), string.replace(text, "@C", ""))
	end
end

function meta:Hud(id, txt, pos, align)
	if self:UserID() ~= 0 then
		RunConsoleCommand("hudtxt2 ".. self:UserID() .." ".. id .." \"".. txt .."\" ".. pos.x .." ".. pos.y .." ".. align)
	end
end

function meta:ClearHud(id)
	if self:UserID() ~= 0 then
		RunConsoleCommand("hudtxt2 ".. self:UserID() .." ".. id .." \"\" 0 0 ".. TEXT_ALIGN_LEFT)
	end
end

function meta:IsBot()
	if self:UserID() == 0 then
		return 1
	else
		return tobool(_player(self:UserID(), "bot"))
	end
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

function meta:GetActiveWeapon()
	if self:Alive() then
		return weapon.GetByType(_player(self:UserID(), "weapontype"))
	else
		return nil
	end
end

function meta:GetWeapons()
	local Table = {}
	if self:Alive() then
		for _, v in pairs(playerweapons(self:UserID())) do
			table.insert(Table, weapon.GetByType(v))
		end
	end
	return Table
end

function meta:CloseItems(ranger)
	local Table = {}
	
	if self:Alive() then
		if ranger == nil or ranger == 0 then ranger = 1 end
		for _, v in pairs(closeitems(self:UserID(), ranger)) do
			table.insert(Table, item.GetByID(v))
		end
		return Table
	end
	
	return Table
end

function meta:IsIdle()
	if self:UserID() == 0 then
		return 0
	else
		return _player(self:UserID(), "idle")
	end
end

function meta:Angle()
	if self:UserID() == 0 then
		return 0
	else
		return _player(self:UserID(), "rot")
	end
end

function meta:HasNightvision()
	if self:UserID() == 0 then
		return 0
	else
		return _player(self:UserID(), "nightvision")
	end
end

function meta:HasDefusekit()
	if self:UserID() == 0 then
		return 0
	else
		return _player(self:UserID(), "defusekit")
	end
end

function meta:HasBomb()
	if self:UserID() == 0 then
		return 0
	else
		return _player(self:UserID(), "bomb")
	end
end

function meta:HasFlag()
	if self:UserID() == 0 then
		return 0
	else
		return _player(self:UserID(), "flag")
	end
end

function meta:HasWeapon(index)
	if self:Alive() then
		if type(index) == "string" then index = tonumber(index) end
		for k, v in pairs(self:GetWeapons()) do
			if index == v:Type() then
				return true
			end
		end
		
		return false
	else
		return false
	end
end

function meta:StripWeapon(index)
	if self:Alive() then
		if index == nil then index = self:GetActiveWeapon():Type() end
		if type(index) == "string" then index = tonumber(index) end
		if self:HasWeapon(index) then
			RunConsoleCommand("strip ".. self:UserID() .." ".. index)
		end
	end
end

function meta:StripWeapons()
	if self:Alive() then
		for k, v in pairs(self:GetWeapons()) do
			self:StripWeapon(v:Type())
		end
	end
end

function meta:DropWeapon(index)
	if self:Alive() then
		if index == nil then index = self:GetActiveWeapon():Type() end
		if type(index) == "string" then index = tonumber(index) end
		if self:HasWeapon(index) then
			self:StripWeapon(index)
			RunConsoleCommand("spawnitem ".. index .." ".. self:Tile().x .." ".. self:Tile().y)
		end
	end
end

function meta:SelectWeapon(index)
	if self:Alive() then
		if type(index) == "string" then index = tonumber(index) end
		if self:HasWeapon(index) then
			RunConsoleCommand("setweapon ".. self:UserID() .." ".. index)
		end
	end
end

function meta:Give(index)
	if self:Alive() then
		if not self:HasWeapon(index) and (index ~= ITEM_REDFLAG or index ~= ITEM_BLUEFLAG) then
			RunConsoleCommand("equip ".. self:UserID() .." ".. index)
			self:SelectWeapon(index)
		end
	end
end

function meta:Look()
	if self:UserID() == 0 then
		return 0
	else
		return _player(self:UserID(), "look")
	end
end
