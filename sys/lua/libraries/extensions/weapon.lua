local meta = CreateMetaTable("Weapon")

weapon = {}

function weapon.GetByType(type)
	if itemtype(type, "name") == "" and type ~= 250 then return nil end
	local Table = CopyMetaTable("Weapon")
	Table.Index = type
	return Table
end

function meta:Type()
	return self.Index
end

function meta:Name()
	if self:Type() == 250 then
		return "Custom"
	else
		return itemtype(self:Type(), "name")
	end
end

function meta:Domage()
	if self:Type() == 250 then
		return 0
	else
		return itemtype(self:Type(), "dmg")
	end
end

function meta:Zoom1()
	if self:Type() == 250 then
		return 0
	else
		return itemtype(self:Type(), "dmz_z1")
	end
end

function meta:Zoom2()
	if self:Type() == 250 then
		return 0
	else
		return itemtype(self:Type(), "dmg_z2")
	end
end

function meta:Rate()
	if self:Type() == 250 then
		return 0
	else
		return itemtype(self:Type(), "rate")
	end
end

function meta:Reload()
	if self:Type() == 250 then
		return 0
	else
		return itemtype(self:Type(), "reload")
	end
end
	
function meta:Ammo()
	if self:Type() == 250 then
		return 0
	else
		return itemtype(self:Type(), "ammo")
	end
end

function meta:Ammoin()
	if self:Type() == 250 then
		return 0
	else
		return itemtype(self:Type(), "ammoin")
	end
end

function meta:Price()
	if self:Type() == 250 then
		return 0
	else
		return itemtype(self:Type(), "price")
	end
end

function meta:Range()
	if self:Type() == 250 then
		return 0
	else
		return itemtype(self:Type(), "range")
	end
end

function meta:Dispersion()
	if self:Type() == 250 then
		return 0
	else
		return itemtype(self:Type(), "dispersion")
	end
end

function meta:Slot()
	if self:Type() == 250 then
		return 0
	else
		return itemtype(self:Type(), "slot")
	end
end

function meta:Recoil()
	if self:Type() == 250 then
		return 0
	else
		return itemtype(self:Type(), "recoil")
	end
end
