team = {}

local TeamInfo = {}
TeamInfo[tostring(TEAM_SPECTATOR)] = {Name = "Spectator", Color = "©255255000", Abr = "spec", Score = 0, Win = 0}
TeamInfo[tostring(TEAM_TERRORIST)] = {Name = "Terrorist", Color = "©255000000", Abr = "t", Score = 0, Win = 0}
TeamInfo[tostring(TEAM_COUNTER_TERRORIST)] = {Name = "Counter-Terrorist", Color = "©050150255", Abr = "ct", Score = 0, Win = 0}

function team.GetColor(index)
	return TeamInfo[tostring(index)].Color
end

function team.GetName(index)
	return TeamInfo[tostring(index)].Name
end

function team.GetPlayers(index)
	local players = {}
	for id, ply in pairs(player.GetAll()) do
		if tostring(ply.Team()) == tostring(index) then
			table.insert(players, ply)
		end
	end
	return players
end

function team.PrintMessage(index, type, message)
	for _, ply in pairs(team.GetPlayers(index)) do
		ply:PrintMessage(type, message)
	end
end

function team.ChatPrint(index, message)
	for _, ply in pairs(team.GetPlayers(index)) do
		ply:ChatPrint(message)
	end
end

function team.NumPlayers(index)
	return #team.GetPlayers(index)
end

function team.Joinable(index)
	if tostring(index) == tostring(TEAM_SPECTATOR) then
		return not _game("sv_specmode") == 2
	elseif _game("mp_autoteambalance") == 1 then
		if index == TEAM_TERRORIST then
			if team.NumPlayers(TEAM_TERRORIST) <= team.NumPlayers(TEAM_COUNTER_TERRORIST) then
				return true
			else
				return false
			end
		elseif index == TEAM_COUNTER_TERRORIST then
			if team.NumPlayers(TEAM_COUNTER_TERRORIST) <= team.NumPlayers(TEAM_TERRORIST) then
				return true
			else
				return false
			end
		end
	else
		return true
	end
end

function team.GetScore(index)
	if tostring(index) == tostring(TEAM_SPECTATOR) then return 0 end
	return _game("score_".. TeamInfo[tostring(index)].Abr)
end

function team.GetWin(index)
	if tostring(index) == tostring(TEAM_SPECTATOR) then return 0 end
	return _game("winrow_".. TeamInfo[tostring(index)].Abr)
end

function team.TotalDeaths(index)
	if tostring(index) == tostring(TEAM_SPECTATOR) then return 0 end
	local score = 0
	for id, ply in pairs(team.GetPlayers(index)) do
		score = score + ply:Deaths()
	end
	return score
end

function team.TotalFrags(index)
	if tostring(index) == tostring(TEAM_SPECTATOR) then return 0 end
	local score = 0
	for id, ply in pairs(team.GetPlayers(index)) do
		score = score + ply:Frags()
	end
	return score
end

function team.GetAllTeams()
	local teams = table.copy(TeamInfo)
	teams[tostring(TEAM_SPECTATOR)].Abr = nil
	teams[tostring(TEAM_TERRORIST)].Abr = nil
	teams[tostring(TEAM_COUNTER_TERRORIST)].Abr = nil
	teams[tostring(TEAM_SPECTATOR)].Score = nil
	teams[tostring(TEAM_SPECTATOR)].Win = nil
	teams[tostring(TEAM_TERRORIST)].Score = team.GetScore(TEAM_TERRORIST)
	teams[tostring(TEAM_COUNTER_TERRORIST)].Score = team.GetScore(TEAM_COUNTER_TERRORIST)
	teams[tostring(TEAM_TERRORIST)].Win = team.GetWin(TEAM_TERRORIST)
	teams[tostring(TEAM_COUNTER_TERRORIST)].Win = team.GetWin(TEAM_COUNTER_TERRORIST)
	return teams
end