local util = import(METALIBDIR ..'/util.lua')

local function pif(public, name, path)
  local private = {}
  private.Item = util.CreateMetaTable('Item')

  function public.Exists(index)
    if not tobool(_item(index, "exists")) then return false end
    return true
  end

  function public.GetByID(index)
    if not public.Exists(index) then return nil end
    local Table = util.CopyMetaTable("Item")
    Table.Index = index
    return Table
  end

  function public.GetAll()
    local Table = {}
    for _, v in pairs(_item(0, "table")) do
      table.insert(Table, public.GetByID(v))
    end
    return Table
  end

  function public.FindByType(type)
    local Table = {}
    for _, v in pairs(public.GetAll()) do
      if v:Type() == type then
        table.insert(Table, v)
      end
    end
    return Table
  end

  function private.Item:ID()
    return self.Index
  end

  function private.Item:Name()
    return item(self:ID(), "name")
  end

  function private.Item:Type()
    return item(self:ID(), "type")
  end

  function private.Item:Owner()
    return item(self:ID(), "player")
  end

  function private.Item:Ammo()
    return item(self:ID(), "ammo")
  end

  function private.Item:Ammoin()
    return item(self:ID(), "ammoin")
  end

  function private.Item:Dropped()
    return item(self:ID(), "dropped")
  end

  function private.Item:DropTimer()
    return item(self:ID(), "droptimer")
  end

  function private.Item:Mode()
    return item(self:ID(), "mode")
  end

  function private.Item:Pos()
    return Vector(item(self:ID(), "x"), item(self:ID(), "y"))
  end
end

return pif
