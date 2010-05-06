local meta = CreateMetaTable("Iteam")

item = {}

function item.GetByIndex(id)
	if id == 0 and not tobool(_item(id, "exists")) then return nil end
	local Table = meta
	Table.ID = id
	return Table
end

function item.GetAll()
	local Table = {}
	for _, v in pairs(_item(0, "table")) do
		table.insert(Table, weapon.GetByIndex(v))
	end
	return Table
end

function meta:ID()
	return self.ID
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

function item.GetByType(type)
	for _, v in pairs(weapon.GetAll()) do
		if v:Type() == type then
			return v
		end
	end
	return nil
end
