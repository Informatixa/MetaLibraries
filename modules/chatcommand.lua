local enum_print_type = import(METALIBDIR ..'/enum/print_types.lua')
local ext_string = import(METALIBDIR ..'/extensions/string.lua')
local util = import(METALIBDIR ..'/util.lua')

MetaLibrariesConst.ChatCommandTable = {}

local function pif(public, name, path)
  local private = {}

  function private.GetTable()
    return MetaLibrariesConst.ChatCommandTable
  end

  function public.Add(name, func)
    local ChatCommandTable = public.GetTable()

    ChatCommandTable[name:lower()] = func
  end

  function public.Remove(name)
    local ChatCommandTable = public.GetTable()

    ChatCommandTable[name:lower()] = nil
  end

  function public.Run(ply, message, sayteam)
    local cmd = string.sub(ext_string.split(" ", message)[1], 2)
    local args = ext_string.split(" ", message:sub(cmd:len() + 3))

    if message:sub(1, 1) == "!" then
      if cmd == "credit" then
        ply:PrintMessage(enum_print_type.HUD_PRINTCENTER, "�255255000Developed by")
        ply:PrintMessage(enum_print_type.HUD_PRINTCENTER, "�050150255MetaInnovative")
        return true
      end

      if message:sub(cmd:len() + 2):len() == 0 then
        args[1] = nil
      end

      for _, v in pairs(args) do
        if util.empty(v) then
          ply:ChatPrint("�255255000The argument is null!")
          return true
        end
      end

      for k, v in pairs(public.GetTable()) do
        if (cmd == k) then
          v(ply, args, sayteam)
          return true
        end
      end

      return true
    end

    return false
  end
end

return pif
