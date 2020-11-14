local enum_gamemode = import(METALIBDIR ..'/enum/gamemodes.lua')

local function pif(public, name, path)
  local private = {}	private.GamemodeInfo = {}
  private.GamemodeInfo[tostring(enum_gamemode.GAMEMODE_STANDARD)] = {Name = "Standard"}
  private.GamemodeInfo[tostring(enum_gamemode.GAMEMODE_DEATHMATCH)] = {Name = "Deathmatch"}
  private.GamemodeInfo[tostring(enum_gamemode.GAMEMODE_TEAM_DEATHMATCH)] = {Name = "Team Deathmatch"}
  private.GamemodeInfo[tostring(enum_gamemode.GAMEMODE_CONSTRUCTION)] = {Name = "Construction"}
  private.GamemodeInfo[tostring(enum_gamemode.GAMEMODE_ZOMBIE)] = {Name = "Zombie!"}

  function public.GetName(index)
    return private.GamemodeInfo[tostring(index)].Name
  end

  function public.GetAllGamemodes()
    local gamemodes = {}
    for k, v in pairs(private.GamemodeInfo) do
      gamemodes[k] = v.Name
    end
    return gamemodes
  end
end

return pif
