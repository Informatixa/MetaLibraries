local meta = CreateMetaTable("Weapon")

weapon = {}

function weapon.GetByType(type)
	local Table = CopyMetaTable("Weapon")
	Table.ID = type
	return Table
end

function meta:Type()
	return self.ID
end

function meta:Name()
	return itemtype(self:Type(), "name")
end

function meta:Domage()
	return itemtype(self:Type(), "dmg")
end

function meta:Zoom1()
	return itemtype(self:Type(), "dmz_z1")
end

function meta:Zoom2()
	return itemtype(self:Type(), "dmg_z2")
end

function meta:Rate()
	return itemtype(self:Type(), "rate")
end

function meta:Reload()
	return itemtype(self:Type(), "reload")
end
	
function meta:Ammo()
	return itemtype(self:Type(), "ammo")
end

function meta:Ammoin()
	return itemtype(self:Type(), "ammoin")
end

function meta:Price()
	return itemtype(self:Type(), "price")
end

function meta:Range()
	return itemtype(self:Type(), "range")
end

function meta:Dispersion()
	return itemtype(self:Type(), "dispersion")
end

function meta:Slot()
	return itemtype(self:Type(), "slot")
end

function meta:Recoil()
	return itemtype(self:Type(), "recoil")
end
