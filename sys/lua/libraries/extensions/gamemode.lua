gamemode = {}local GamemodeInfo = {}GamemodeInfo[tostring(GAMEMODE_STANDARD)] = {Name = "Standard"}GamemodeInfo[tostring(GAMEMODE_DEATHMATCH)] = {Name = "Deathmatch"}GamemodeInfo[tostring(GAMEMODE_TEAM_DEATHMATCH)] = {Name = "Team Deathmatch"}GamemodeInfo[tostring(GAMEMODE_CONSTRUCTION)] = {Name = "Construction"}GamemodeInfo[tostring(GAMEMODE_ZOMBIE)] = {Name = "Zombie!"}function gamemode.GetName(index)	return GamemodeInfo[tostring(index)].Nameendfunction gamemode.GetAllGamemodes()	local gamemodes = {}	for k, v in pairs(GamemodeInfo) do		gamemodes[k] = v.Name	end	return gamemodesend