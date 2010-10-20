local _meta = CreateMetaTable("CreateObject")
local meta = CreateMetaTable("Object")

object = {}

function object.Create(class)
	local Table = CopyMetaTable("CreateObject")
	if class == nil then class = 10 end
	Table.Class = class
	Table.Pos = Vector(0, 0)
	Table.Ang = 0
	Table.Mode = 0
	if class == 9 then Table.Mode = 1 end
	Table.Team = 0
	Table.Player = 0
	return Table
end

function object.GetByIndex(index)
	if index == 0 or not tobool(_object(index, "exists")) then return nil end
	local Table = CopyMetaTable("Object")
	Table.ID = index
	return Table
end

function object.GetAll()
	local Table = {}
	for k, v in pairs(_object(0, "table")) do
		table.insert(Table, object.GetByIndex(v))
	end
	return Table
end

function meta:GetID()
	return self.ID
end

function meta:GetClass()
	return _object(self.ID, "type")
end
function meta:GetClassName()
	return _object(self.ID, "typename")
end

function meta:GetPos()
	return Vector(_object(self.ID, "tilex"), _object(self.ID, "tiley"))
end

function _meta:SetPos(tilex, tiley)
	self.Pos = Vector(tilex, tiley)
end

function meta:GetTeam()
	return _object(self.ID, "team")
end

function _meta:SetTeam(index)
	self.Team = index
end

function meta:GetHealth()
	return _object(self.ID, "health")
end

function meta:GetAng()
	return _object(self.ID, "rot")
end

function _meta:SetAng(ang)
	self.Ang = ang
end

function meta:GetOwner()
	return player.GetByID(_object(self.ID, "player"))
end

function _meta:SetOwner(index)
	self.Player = index
end

function _meta:SetMode(id)
	if id == nil then id = 1 end
	self.Mode = id
end

function object.GetByPos(tilex, tiley)
	for k, v in pairs(object.GetAll()) do
		if v:GetPos().x == tilex and v:GetPos().y == tiley then
			return v
		end
	end
	return nil
end

function _meta:Spawn()
	RunConsoleCommand("spawnobject ".. self.Class .." ".. self.Pos.x .." ".. self.Pos.y .." ".. self.Ang .." ".. self.Mode .." ".. self.Team .." ".. self.Player)
	self.ID = object.GetByPos(self.Pos.x, self.Pos.y):GetID()
	if self.ID ~= nil then
		function self:GetID()
			return self.ID
		end
	end
end

function object.FindByClass(class)
	if class == nil then class = 10 end
	local Table = {}
	for k, v in pairs(object.GetAll()) do
		if v:GetClass() == class then
			table.insert(Table, v)
		end
	end
	return Table
end
