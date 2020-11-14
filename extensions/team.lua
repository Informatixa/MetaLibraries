local enum_team = import(METALIBDIR ..'/enum/teams.lua')
local ext_player = import(METALIBDIR ..'/extensions/player.lua')

local function pif(public, name, path)
  local private = {}
  private.TeamInfo = {}
  private.TeamInfo[tostring(enum_team.TEAM_SPECTATOR)] = {Name = 'Spectator', Color = '�255220000', Abr = 'spec', Score = 0, Win = 0}
  private.TeamInfo[tostring(enum_team.TEAM_TERRORIST)] = {Name = 'Terrorist', Color = '�255025000', Abr = 't', Score = 0, Win = 0}
  private.TeamInfo[tostring(enum_team.TEAM_COUNTER_TERRORIST)] = {Name = 'Counter-Terrorist', Color = '�050150255', Abr = 'ct', Score = 0, Win = 0}

  function public.GetColor(index)
    return private.TeamInfo[tostring(index)].Color
  end

  function public.GetName(index)
    return private.TeamInfo[tostring(index)].Name
  end

  function public.GetPlayers(index)
    local players = {}
    if index < 0 or index > 2 then return players end
    for _, v in pairs(player(0, 'team'.. index)) do
      table.insert(players, ext_player.GetByID(v))
    end
    return players
  end

  function public.GetPlayersLiving(index)
    local players = {}
    if index < 1 or index > 2 then return players end
    for _, v in pairs(player(0, 'team'.. index ..'living')) do
      table.insert(players, ext_player.GetByID(v))
    end
    return players
  end

  function public.PrintMessage(index, type, message)
    for _, ply in pairs(public.GetPlayers(index)) do
      ply:PrintMessage(type, message)
    end
  end

  function public.ChatPrint(index, message)
    for _, ply in pairs(public.GetPlayers(index)) do
      ply:ChatPrint(message)
    end
  end

  function public.NumPlayers(index)
    return #public.GetPlayers(index)
  end

  function public.NumPlayersLiving(index)
    return #public.GetPlayersLiving(index)
  end

  function public.Joinable(index)
    if tostring(index) == tostring(enum_team.TEAM_SPECTATOR) then
      return not game('sv_specmode') == 2
    elseif game('mp_autoteambalance') == 1 then
      if index == enum_team.TEAM_TERRORIST then
        if public.NumPlayers(enum_team.TEAM_TERRORIST) <= public.NumPlayers(enum_team.TEAM_COUNTER_TERRORIST) then
          return true
        else
          return false
        end
      elseif index == enum_team.TEAM_COUNTER_TERRORIST then
        if public.NumPlayers(enum_team.TEAM_COUNTER_TERRORIST) <= public.NumPlayers(enum_team.TEAM_TERRORIST) then
          return true
        else
          return false
        end
      end
    else
      return true
    end
  end

  function public.GetScore(index)
    if tostring(index) == tostring(enum_team.TEAM_SPECTATOR) then return 0 end
    return game('score_'.. private.TeamInfo[tostring(index)].Abr)
  end

  function public.GetWin(index)
    if tostring(index) == tostring(enum_team.TEAM_SPECTATOR) then return 0 end
    return game('winrow_'.. private.TeamInfo[tostring(index)].Abr)
  end

  function public.TotalDeaths(index)
    if tostring(index) == tostring(enum_team.TEAM_SPECTATOR) then return 0 end
    local score = 0
    for id, ply in pairs(public.GetPlayers(index)) do
      score = score + ply:Deaths()
    end
    return score
  end

  function public.TotalFrags(index)
    if tostring(index) == tostring(enum_team.TEAM_SPECTATOR) then return 0 end
    local score = 0
    for id, ply in pairs(public.GetPlayers(index)) do
      score = score + ply:Frags()
    end
    return score
  end

  function public.GetAllTeams()
    local teams = table.copy(private.TeamInfo)
    teams[tostring(enum_team.TEAM_SPECTATOR)].Abr = nil
    teams[tostring(enum_team.TEAM_TERRORIST)].Abr = nil
    teams[tostring(enum_team.TEAM_COUNTER_TERRORIST)].Abr = nil
    teams[tostring(enum_team.TEAM_SPECTATOR)].Score = nil
    teams[tostring(enum_team.TEAM_SPECTATOR)].Win = nil
    teams[tostring(enum_team.TEAM_TERRORIST)].Score = public.GetScore(enum_team.TEAM_TERRORIST)
    teams[tostring(enum_team.TEAM_COUNTER_TERRORIST)].Score = public.GetScore(enum_team.TEAM_COUNTER_TERRORIST)
    teams[tostring(enum_team.TEAM_TERRORIST)].Win = public.GetWin(enum_team.TEAM_TERRORIST)
    teams[tostring(enum_team.TEAM_COUNTER_TERRORIST)].Win = public.GetWin(enum_team.TEAM_COUNTER_TERRORIST)
    return teams
  end
end

return pif
