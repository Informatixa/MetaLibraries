local meta = CreateMetaTable("Entity")

entity = {}

function entity.GetByPos(tilex, tiley)
	if not map.InEntity(tilex, tiley) then return nil end
	local Table = CopyMetaTable("Entity")
	Table.Index = Vector(tilex, tiley)
	return Table
end

function entity.GetAll()
	local Table = {}
	for x = 0, map.GetSize().x do
		for y = 0, map.GetSize().y do
			if map.InEntity(x, y) then
				table.insert(Table, entity.GetByPos(x, y))
			end
		end
	end
	return Table
end

function entity.FindByType(type)
	local Table = {}
	for k, v in pairs(entity.GetAll()) do
		if v:Type() == type then
			table.insert(Table, v)
		end
	end
	return Table
end

function entity.Random(type, ai, i0)
	if i0 ~= nil then
		local x, y = randomentity(type, ai, i0)
	elseif ai ~= nil then
		local x, y = randomentity(type, ai)
	else
		local x, y = randomentity(type)
	end
	return entity.GetByPos(x, y)
end

function meta:Pos()
	return self.Index
end

function meta:Type()
	return _entity(self:Pos().x, self:Pos().y, "type")	
end

function meta:TypeName()
	return _entity(self:Pos().x, self:Pos().y, "typename")	
end

function meta:Name()
	return _entity(self:Pos().x, self:Pos().y, "name")	
end

function meta:Trigger()
	return _entity(self:Pos().x, self:Pos().y, "trigger")	
end

function meta:State()
	return _entity(self:Pos().x, self:Pos().y, "state")	
end

function meta:Int0()
	return _entity(self:Pos().x, self:Pos().y, "int0")	
end

function meta:Int1()
	return _entity(self:Pos().x, self:Pos().y, "int1")	
end

function meta:Int2()
	return _entity(self:Pos().x, self:Pos().y, "int2")	
end

function meta:Int3()
	return _entity(self:Pos().x, self:Pos().y, "int3")	
end

function meta:Int4()
	return _entity(self:Pos().x, self:Pos().y, "int4")	
end

function meta:Int5()
	return _entity(self:Pos().x, self:Pos().y, "int5")	
end

function meta:Int6()
	return _entity(self:Pos().x, self:Pos().y, "int6")	
end

function meta:Int7()
	return _entity(self:Pos().x, self:Pos().y, "int7")	
end

function meta:Int8()
	return _entity(self:Pos().x, self:Pos().y, "int8")	
end

function meta:Int9()
	return _entity(self:Pos().x, self:Pos().y, "int9")	
end

function meta:Str0()
	return _entity(self:Pos().x, self:Pos().y, "str0")	
end

function meta:Str1()
	return _entity(self:Pos().x, self:Pos().y, "str1")	
end

function meta:Str2()
	return _entity(self:Pos().x, self:Pos().y, "str2")	
end

function meta:Str3()
	return _entity(self:Pos().x, self:Pos().y, "str3")	
end

function meta:Str4()
	return _entity(self:Pos().x, self:Pos().y, "str4")	
end

function meta:Str5()
	return _entity(self:Pos().x, self:Pos().y, "str5")	
end

function meta:Str6()
	return _entity(self:Pos().x, self:Pos().y, "str6")	
end

function meta:Str7()
	return _entity(self:Pos().x, self:Pos().y, "str7")	
end

function meta:Str8()
	return _entity(self:Pos().x, self:Pos().y, "str8")	
end

function meta:Str9()
	return _entity(self:Pos().x, self:Pos().y, "str9")	
end

function meta:aiState()
	return _entity(self:Pos().x, self:Pos().y, "aistate")	
end
