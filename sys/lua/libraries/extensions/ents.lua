local _meta = CreateMetaTable("CreateEntity")
local meta = CreateMetaTable("Entity")

ents = {}
local _class = {["barricade"] = ENTITY_BARRICADE, ["barbed_wire"] = ENTITY_BARDED_WIRE, ["wall_i"] = ENTITY_WALL_I, ["wall_ii"] = ENTITY_WALL_II, ["wall_iii"] = ENTITY_WALL_III, ["gate_field"] = ENTITY_GATE_FIELD, ["dispenser"] = ENTITY_DISPENSER, ["turret"] = ENTITY_TURRET, ["supply"] = ENTITY_SUPPLY, ["construction_site"] = ENTITY_CONSTRUCTION, ["dual_turret"] = ENTITY_DUAL_TURRET, ["triple_turret"] = ENTITY_TRIPLE_TURRET, ["teleporter_entrance"] = ENTITY_TELEPORTER_ENTRANCE, ["teleporter_exit"] = ENTITY_TELEPORTER_EXIT, ["mine"] = ENTITY_MINE, ["laser_mine"] = ENTITY_LASER_MINE, ["portal_red"] = ENTITY_PORTAL_RED, ["portal_blue"] = ENTITY_PORTAL_BLUE}
local _mode = {["grenades"] = SUPPLY_GRENADES, ["kevlarhelm"] = SUPPLY_KEVLARHELM, ["shotguns"] = SUPPLY_SHOTGUNS, ["smgs"] = SUPPLY_SMGS, ["rifles"] = SUPPLY_RIFLES, ["sniperrifles"] = SUPPLY_SNIPERRIFLES, ["armor"] = SUPPLY_ARMOR, ["rpglauncher"] = SUPPLY_RPGLAUNCHER}

function ents.Create(class)
	local Table = CopyMetaTable("CreateEntity")
	if type(class) == "string" then class = _class[class:lower()] end
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

function ents.GetByIndex(index)
	if index == 0 or not tobool(object(index, "exists")) then return nil end
	local Table = CopyMetaTable("Entity")
	Table.ID = index
	return Table
end

function ents.GetAll()
	local Table = {}
	for k, v in pairs(object(0, "table")) do
		table.insert(Table, ents.GetByIndex(v))
	end
	return Table
end

function meta:GetID()
	return self.ID
end

function meta:GetClass()
	return object(self.ID, "type")
end
function meta:GetClassName()
	return object(self.ID, "typename")
end

function meta:GetPos()
	return Vector(object(self.ID, "tilex"), object(self.ID, "tiley"))
end

function _meta:SetPos(tilex, tiley)
	self.Pos = Vector(tilex, tiley)
end

function meta:GetTeam()
	return object(self.ID, "team")
end

function _meta:SetTeam(index)
	self.Team = index
end

function meta:GetHealth()
	return object(self.ID, "health")
end

function meta:GetAng()
	return object(self.ID, "rot")
end

function _meta:SetAng(ang)
	self.Ang = ang
end

function meta:GetOwner()
	return player.GetByID(object(self.ID, "player"))
end

function _meta:SetOwner(index)
	self.Player = index
end

function _meta:SetMode(id)
	if type(id) == "string" then id = _mode[id:lower()] end
	if id == nil then id = 1 end
	self.Mode = id
end

function ents.GetByPos(tilex, tiley)
	for k, v in pairs(ents.GetAll()) do
		if v:GetPos().x == tilex and v:GetPos().y == tiley then
			return v
		end
	end
	return nil
end

function _meta:Spawn()
	RunConsoleCommand("spawnobject ".. self.Class .." ".. self.Pos.x .." ".. self.Pos.y .." ".. self.Ang .." ".. self.Mode .." ".. self.Team .." ".. self.Player)
	self.ID = ents.GetByPos(self.Pos.x, self.Pos.y):GetID()
	if self.ID ~= nil then
		function self:GetID()
			return self.ID
		end
	end
end

function ents.FindByClass(class)
	if type(class) == "string" then class = _class[class:lower()] end
	if class == nil then class = 10 end
	local Table = {}
	for k, v in pairs(ents.GetAll()) do
		if v:GetClass() == class then
			table.insert(Table, v)
		end
	end
	return Table
end
