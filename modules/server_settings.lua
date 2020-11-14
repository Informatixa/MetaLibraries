local util = import(METALIBDIR ..'/util.lua')
local mod_concommand = import(METALIBDIR ..'/modules/concommand.lua')

MetaLibrariesConst.ConVarTable = {}

local function pif(public, name, path)
  local private = {}
  private.ServerSettings = util.CreateMetaTable("ServerSettings")

  function private.GetTable()
    return MetaLibrariesConst.ConVarTable
  end

  function public.ConVarExists(name)
    if name == "sv_password" or name == "sv_rcon" or name == "mp_unbuildable" or name == "mp_unbuyable" or name == "mp_reservations" then return true end
    if game(name) == "" and MetaLibrariesConst.ConVarTable[name] == nil then return false end
    return true
  end

  function public.CreateConVar(name, value)
    local ConVarTable = private.GetTable()
    ConVarTable[name] = value

    mod_concommand.Add(name, function(cmd, args)
      ConVarTable[cmd] = args[1]
    end)
  end

  function public.GetConVarInt(name, default)
    local ConVarTable = private.GetTable()

    if public.ConVarExists(name) then
      if ConVarTable[name] ~= nil then
        return tonumber(ConVarTable[name])
      else
        return tonumber(game(name))
      end
    else
      return default or 0
    end
  end

  function public.GetConVarBool(name, default)
    local ConVarTable = private.GetTable()

    if public.ConVarExists(name) then
      if ConVarTable[name] ~= nil then
        return util.tobool(ConVarTable[name])
      else
        return util.tobool(game(name))
      end
    else
      return default or false
    end
  end

  function public.GetConVarString(name, default)
    local ConVarTable = private.GetTable()

    if public.ConVarExists(name) then
      if ConVarTable[name] ~= nil then
        return tostring(ConVarTable[name])
      else
        return tostring(game(name))
      end
    else
      return default or ""
    end
  end

  function GetConVar(name)
    local var = util.CopyMetaTable("ServerSettings")
    var.Name = name
    return var
  end

  function private.ServerSettings:GetInt()
    return public.GetConVarInt(self.Name, 0)
  end

  function private.ServerSettings:GetBool()
    return public.GetConVarBool(self.Name, false)
  end

  function private.ServerSettings:GetString(name, default)
    return public.GetConVarString(self.Name, "")
  end

  function public.SinglePlayer()
    return public.GetConVarBool("sv_lan", false)
  end
end

return pif
