local util = import(METALIBDIR ..'/util.lua')
local ext_map = import(METALIBDIR ..'/extensions/map.lua')

local function pif(public, name, path)
  local private = {}
  private.Entity = util.CreateMetaTable('Entity')

  function public.GetByPos(tilex, tiley)
    if not ext_map.InEntity(tilex, tiley) then return nil end
    local Table = util.CopyMetaTable('Entity')
    Table.Index = util.Vector(tilex, tiley)
    return Table
  end

  function public.GetAll()
    local Table = {}
    for x = 0, ext_map.GetSize().x do
      for y = 0, ext_map.GetSize().y do
        if ext_map.InEntity(x, y) then
          table.insert(Table, public.GetByPos(x, y))
        end
      end
    end
    return Table
  end

  function public.FindByType(type)
    local Table = {}
    for k, v in pairs(public.GetAll()) do
      if v:Type() == type then
        table.insert(Table, v)
      end
    end
    return Table
  end

  function public.Random(type, ai, i0)
    if i0 ~= nil then
      local x, y = randomentity(type, ai, i0)
    elseif ai ~= nil then
      local x, y = randomentity(type, ai)
    else
      local x, y = randomentity(type)
    end
    return public.GetByPos(x, y)
  end

  function private.Entity:Pos()
    return self.Index
  end

  function private.Entity:Type()
    return entity(self:Pos().x, self:Pos().y, 'type')
  end

  function private.Entity:TypeName()
    return entity(self:Pos().x, self:Pos().y, 'typename')
  end

  function private.Entity:Name()
    return entity(self:Pos().x, self:Pos().y, 'name')
  end

  function private.Entity:Trigger()
    return entity(self:Pos().x, self:Pos().y, 'trigger')
  end

  function private.Entity:State()
    return entity(self:Pos().x, self:Pos().y, 'state')
  end

  function private.Entity:Int0()
    return entity(self:Pos().x, self:Pos().y, 'int0')
  end

  function private.Entity:Int1()
    return entity(self:Pos().x, self:Pos().y, 'int1')
  end

  function private.Entity:Int2()
    return entity(self:Pos().x, self:Pos().y, 'int2')
  end

  function private.Entity:Int3()
    return entity(self:Pos().x, self:Pos().y, 'int3')
  end

  function private.Entity:Int4()
    return entity(self:Pos().x, self:Pos().y, 'int4')
  end

  function private.Entity:Int5()
    return entity(self:Pos().x, self:Pos().y, 'int5')
  end

  function private.Entity:Int6()
    return entity(self:Pos().x, self:Pos().y, 'int6')
  end

  function private.Entity:Int7()
    return entity(self:Pos().x, self:Pos().y, 'int7')
  end

  function private.Entity:Int8()
    return entity(self:Pos().x, self:Pos().y, 'int8')
  end

  function private.Entity:Int9()
    return entity(self:Pos().x, self:Pos().y, 'int9')
  end

  function private.Entity:Str0()
    return entity(self:Pos().x, self:Pos().y, 'str0')
  end

  function private.Entity:Str1()
    return entity(self:Pos().x, self:Pos().y, 'str1')
  end

  function private.Entity:Str2()
    return entity(self:Pos().x, self:Pos().y, 'str2')
  end

  function private.Entity:Str3()
    return entity(self:Pos().x, self:Pos().y, 'str3')
  end

  function private.Entity:Str4()
    return entity(self:Pos().x, self:Pos().y, 'str4')
  end

  function private.Entity:Str5()
    return entity(self:Pos().x, self:Pos().y, 'str5')
  end

  function private.Entity:Str6()
    return entity(self:Pos().x, self:Pos().y, 'str6')
  end

  function private.Entity:Str7()
    return entity(self:Pos().x, self:Pos().y, 'str7')
  end

  function private.Entity:Str8()
    return entity(self:Pos().x, self:Pos().y, 'str8')
  end

  function private.Entity:Str9()
    return entity(self:Pos().x, self:Pos().y, 'str9')
  end

  function private.Entity:aiState()
    return entity(self:Pos().x, self:Pos().y, 'aistate')
  end
end

return pif
