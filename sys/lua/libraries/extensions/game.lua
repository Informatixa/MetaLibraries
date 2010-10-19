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
