local ext_map = import(METALIBDIR ..'/extensions/map.lua')

local function pif(public, name, path)
  function public.GetMapNext()
    return game('nextmap')
  end

  function public.LoadNextMap()
    parse('changelevel '.. public.GetMapNext())
  end

  function public.GetMap()
    return ext_map.GetName()
  end

  function public.ChangeMap(map)
    parse('changelevel '.. map)
  end

  function public.ChangeGamemode(index)
    parse('sv_gamemode '.. index)
  end

  function public.Version()
    return game('version')
  end

  function public.Dedicated()
    return game('dedicated')
  end

  function public.Phase()
    return game('phase')
  end

  function public.Round()
    return game('round')
  end

  function public.Port()
    return game('port')
  end

  function public.BombPlanted()
    return game('bombplanted')
  end
end

return pif
