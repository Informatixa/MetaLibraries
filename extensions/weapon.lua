local util = import(METALIBDIR ..'/util.lua')

local function pif(public, name, path)
  local private = {}
  private.Weapon = util.CreateMetaTable('Weapon')

  function public.Exists(type)
    if (type >= 1 and type <= 6) or type == 10 or type == 11 or (type >= 20 and type <= 24) or (type >= 30 and type <= 51) or (type >= 69 and type <= 78) or (type >= 85 and type <= 87) or (type >= 89 and type <= 91) then return true end
    return false
  end

  function public.GetByType(type)
    if not public.Exists(type) then return nil end
    local Table = util.CopyMetaTable('Weapon')
    Table.Index = type
    return Table
  end

  function private.Weapon:Type()
    return self.Index
  end

  function private.Weapon:Name()
    if self:Type() == 250 then
      return 'Custom'
    else
      return itemtype(self:Type(), 'name')
    end
  end

  function private.Weapon:Domage()
    if self:Type() == 250 then
      return 0
    else
      return itemtype(self:Type(), 'dmg')
    end
  end

  function private.Weapon:Zoom1()
    if self:Type() == 250 then
      return 0
    else
      return itemtype(self:Type(), 'dmz_z1')
    end
  end

  function private.Weapon:Zoom2()
    if self:Type() == 250 then
      return 0
    else
      return itemtype(self:Type(), 'dmg_z2')
    end
  end

  function private.Weapon:Rate()
    if self:Type() == 250 then
      return 0
    else
      return itemtype(self:Type(), 'rate')
    end
  end

  function private.Weapon:Reload()
    if self:Type() == 250 then
      return 0
    else
      return itemtype(self:Type(), 'reload')
    end
  end

  function private.Weapon:Ammo()
    if self:Type() == 250 then
      return 0
    else
      return itemtype(self:Type(), 'ammo')
    end
  end

  function private.Weapon:Ammoin()
    if self:Type() == 250 then
      return 0
    else
      return itemtype(self:Type(), 'ammoin')
    end
  end

  function private.Weapon:Price()
    if self:Type() == 250 then
      return 0
    else
      return itemtype(self:Type(), 'price')
    end
  end

  function private.Weapon:Range()
    if self:Type() == 250 then
      return 0
    else
      return itemtype(self:Type(), 'range')
    end
  end

  function private.Weapon:Dispersion()
    if self:Type() == 250 then
      return 0
    else
      return itemtype(self:Type(), 'dispersion')
    end
  end

  function private.Weapon:Slot()
    if self:Type() == 250 then
      return 0
    else
      return itemtype(self:Type(), 'slot')
    end
  end

  function private.Weapon:Recoil()
    if self:Type() == 250 then
      return 0
    else
      return itemtype(self:Type(), 'recoil')
    end
  end
end

return pif
