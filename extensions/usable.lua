local util = import(METALIBDIR ..'/util.lua')

local function pif(public, name, path)
  local private = {}
  private.Usable1 = util.CreateMetaTable('Usable1')
  private.Usable2 = util.CreateMetaTable('Usable2')
  private.Usable3 = util.CreateMetaTable('Usable3')

  function public.Exists(type)
    if (type >= 52 and type <= 59) or (type >= 60 and type <= 62) or (type >= 64 and type <= 68) or (type >= 79 and type <= 84) or type == 88 then return true end
    return false
  end

  function public.GetByType(type)
    if not public.Exists(type) then return nil end
    local Table = nil
    if (type >= 56 and type <= 59) or type == 61 or type == 62 then
      Table = util.CopyMetaTable('Usable1')
    elseif type == 55 or type == 60 or (type >= 64 and type <= 68) or (type >= 79 and type <= 83) then
      Table = util.CopyMetaTable('Usable2')
    elseif (type >= 52 and type <= 54) or type == 84 or type == 88 then
      Table = util.CopyMetaTable('Usable3')
    end
    Table.Index = type
    return Table
  end

  function private.Type(self)
    return self.Index
  end

  function private.Name(self)
    return itemtype(self.Index, 'name')
  end

  function private.Price(self)
    return itemtype(self.Index, 'price')
  end

  function private.Usable1:Type()
    return private.Type(self)
  end

  function private.Usable1:Name()
    return private.Name(self)
  end

  function private.Usable1:Price()
    return private.Price(self)
  end

  function private.Usable2:Type()
    return private.Type(self)
  end

  function private.Usable2:Name()
    return private.Name(self)
  end

  function private.Usable3:Type()
    return private.Type(self)
  end

  function private.Usable3:Name()
    return private.Name(self)
  end

  function private.Usable3:Amount()
    return itemtype(self:Type(), 'ammoin')
  end

  function private.Usable3:Price()
    return private.Price(self)
  end

  function private.Usable3:Range()
    return itemtype(self:Type(), 'range')
  end

  function private.Usable3:Slot()
    return itemtype(self:Type(), 'slot')
  end

  function private.Usable3:Recoil()
    return itemtype(self:Type(), 'recoil')
  end
end

return pif
