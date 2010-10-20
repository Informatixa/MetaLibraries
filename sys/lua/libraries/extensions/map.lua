map = {}

function map.GetName()
	return _map("name")
end

function map.GetSize()
	return Vector(_map("xsize"), _map("ysize"))
end

function map.GetVips()
	return _map("mission_vips")
end

function map.GetHostages()
	return _map("mission_hostages")
end

function map.GetBombSpots()
	return _map("mission_bombspots")
end

function map.GetCtfFlags()
	return _map("mission_ctfflags")
end

function map.GetDomPoints()
	return _map("mission_dompoints")
end

function map.GetBotNodes()
	return _map("botnodes")
end

function map.IsNoBuying()
	return _map("nobuying")
end

function map.IsNoWeapons()
	return _map("noweapons")
end

function map.GetTeleporters()
	return _map("teleporters")
end

function map.InEntity(tilex, tiley)
	return tobool(entity(tilex, tiley, "exists"))
end
