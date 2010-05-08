util = {}
convert = {}

function util.tobool(val)
	return tobool(val)
end

function convert.pos(tilex, tiley)
	return Vector(math.floor(tilex * 32 + 16), math.floor(tiley * 32  + 16))
end

function convert.tile(x, y)
	return Vector(math.floor(x / 32), math.floor(y / 32))
end
