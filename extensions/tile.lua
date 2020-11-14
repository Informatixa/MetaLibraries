local ext_entity = import(METALIBDIR ..'/extensions/entity.lua')


local function pif(public, name, path)
  local private = {}

  function public.Frame(tilex, tiley)
    return tile(tilex, tiley, 'frame')
  end

  function public.Property(tilex, tiley)
    return tile(tilex, tiley, 'property')
  end

  function public.Walkable(tilex, tiley)
    return tile(tilex, tiley, 'walkable')
  end

  function public.Deadly(tilex, tiley)
    return tile(tilex, tiley, 'deadly')
  end

  function public.Wall(tilex, tiley)
    return tile(tilex, tiley, 'wall')
  end

  function public.Obstacle(tilex, tiley)
    return tile(tilex, tiley, 'obstacle')
  end

  function public.Entity(tilex, tiley)
    return ext_entity.GetByPos(tilex, tiley)
  end

  function public.Object(tilex, tiley)
    return ext_object.GetByPos(tilex, tiley)
  end


