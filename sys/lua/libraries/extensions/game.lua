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
