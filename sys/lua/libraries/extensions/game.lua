game = {}

function game.GetMapNext()
	return _game("nextmap")
end

function game.LoadNextMap()
	RunConsoleCommand("changelevel ".. Games.GetMapNext())
end

function game.GetMap()
	return Map.GetName()
end

function game.ChangeMap(map)
	RunConsoleCommand("changelevel ".. map)
end

function game.ChangeGamemode(index)
	RunConsoleCommand("sv_gamemode ".. index)
end

function game.Version()
	return _game("version")
end

function game.Dedicated()
	return _game("dedicated") or ""
end

function game.Phase()
	return _game("Phase")
end

function game.Round()
	return _game("round")
end

function game.BombPlanted()
	return _game("bombplanted")
end
