tile = {}function tile.Frame(tilex, tiley)	return _tile(tilex, tiley, "frame")endfunction tile.Property(tilex, tiley)	return _tile(tilex, tiley, "property")endfunction tile.Walkable(tilex, tiley)	return _tile(tilex, tiley, "walkable")endfunction tile.Deadly(tilex, tiley)	return _tile(tilex, tiley, "deadly")endfunction tile.Wall(tilex, tiley)	return _tile(tilex, tiley, "wall")endfunction tile.Obstacle(tilex, tiley)	return _tile(tilex, tiley, "obstacle")endfunction tile.Entity(tilex, tiley)	return entity.GetByPos(tilex, tiley)endfunction tile.Object(tilex, tiley)	return object.GetByPos(tilex, tiley)end