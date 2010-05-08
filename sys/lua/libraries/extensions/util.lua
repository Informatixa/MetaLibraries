util = {}
convert = {}

function util.tobool(val)
	return tobool(val)
end

function convert.pos(tilex, tiley)
	return Vector(math.floor(tilex * 32.3), math.floor(tiley * 40))
end

function convert.tile(x, y)
	return Vector(math.floor(x / 32.3), math.floor(y / 32.3))
end
