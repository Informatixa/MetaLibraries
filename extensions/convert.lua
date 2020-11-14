local function pif(pub, name, path)
	function pub.pos(tilex, tiley)
		return util.Vector(math.floor(tilex * 32 + 16), math.floor(tiley * 32  + 16))
	end

	function pub.tile(x, y)
		return util.Vector(math.floor(x / 32), math.floor(y / 32))
	end
end

return pif