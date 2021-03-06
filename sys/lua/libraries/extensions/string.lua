function string.totable(str)
	local tab = {}
	for i = 1, string.len(str) do
		table.insert(tab, string.sub(str, i, i))
	end
	return tab
end

function string.explode(seperator, str)
	if seperator == "" then return string.totable(str) end
	local tble = {}	
	local ll = 0
	while true do
		l = string.find( str, seperator, ll, true )
		
		if l ~= nil then
			table.insert(tble, string.sub(str, ll, l - 1)) 
			ll = l + 1
		else
			table.insert(tble, string.sub(str, ll))
			break
		end
	end
	return tble
end

function string.left(str, num)
	return string.sub(str, 1, num)
end

function string.right(str, num)
	return string.sub(str, -num)
end

function string.replace(str, tofind, toreplace)
	local start = 1
	while true do
		local pos = string.find(str, tofind, start, true)
	
		if pos == nil then
			break
		end
		
		local left = string.sub(str, 1, pos-1)
		local right = string.sub(str, pos + #tofind)
		
		str = left .. toreplace .. right
		start = pos + #toreplace
	end
	return str
end

function string.trim( s, char )
	if char == nil then char = "%s" end
	return string.gsub(s, "^".. char .."*(.-)".. char .."*$", "%1")
end

function string.trimright(s, char)
	if char == nil then char = " " end	
	if string.sub(s, -1) == char then
		s = string.sub(s, 0, -2)
		s = string.trimright(s, char)
	end
	return s
end

function string.trimleft(s, char)
	if char == nil then char = " " end	
	if string.sub( s, 1 ) == char then
		s = string.sub(s, 1)
		s = string.TrimLeft(s, char)
	end
	return s
end
