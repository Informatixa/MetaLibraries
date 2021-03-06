local meta = CreateMetaTable("Item")

item = {}

function item.GetByID(index)
	if index == 0 or not tobool(_item(index, "exists")) then return nil end
	local Table = CopyMetaTable("Item")
	Table.Index = index
	return Table
end

function item.GetAll()
	local Table = {}
	for _, v in pairs(_item(0, "table")) do
		table.insert(Table, item.GetByID(v))
	end
	return Table
end

function meta:ID()
	return self.Index
end

function meta:Name()
	return _item(self:ID(), "name")
end

function meta:Type()
	return _item(self:ID(), "type")
end

function meta:Owner()
	return _item(self:ID(), "player")
end

function meta:Ammo()
	return _item(self:ID(), "ammo")
end

function meta:Ammoin()
	return _item(self:ID(), "ammoin")
end

function meta:Dropped()
	return _item(self:ID(), "dropped")
end

function meta:DropTimer()
	return _item(self:ID(), "droptimer")
end

function meta:Mode()
	return _item(self:ID(), "mode")
end

function meta:Pos()
	return Vector(_item(self:ID(), "x"), _item(self:ID(), "y"))
end

function item.FindByType(type)
	local Table = {}
	for _, v in pairs(weapon.GetAll()) do
		if v:Type() == type then
			table.insert(Table, v)
		end
	end
	return Table
end
