local enum_hook = import(METALIBDIR ..'/enum/hooks.lua')
local mod_hook = import(METALIBDIR ..'/modules/hook.lua')

MetaLibrariesConst.ConCommandTable = {}

local function pif(public, name, path)
  local private = {}

  function private.GetTable()
    return MetaLibrariesConst.ConCommandTable
  end

  function public.Add(name, func)
    local ConCommandTable = public.GetTable()

    ConCommandTable[name:lower()] = func
  end

  function public.Remove(name)
    local ConCommandTable = public.GetTable()

    ConCommandTable[name:lower()] = nil
  end

  function public.Run(cmd, args)
    local ConCommandTable = public.GetTable()

    if ConCommandTable[cmd:lower()] ~= nil then
      ConCommandTable[cmd:lower()](args)
      return true
    else
      return false
    end
  end

  mod_hook.Add("parse", "ConCommand", function(cmd, args)
    if public.Run(cmd, args) then return enum_hook.HOOK_NOPARSE else return enum_hook.HOOK_PARSE end
  end)
end

return pif
