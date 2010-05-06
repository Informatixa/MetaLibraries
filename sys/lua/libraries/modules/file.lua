file = {}

function file.Exists(filename)
	local file = io.open("sys/lua/".. filename)
	if file then
		io.close(file)
		return true
	else
		return false
	end
end

function file.Read(filename)
	if not file.Exists(filename) then return "" end
	local file = assert(io.open("sys/lua/".. filename, "r"))
	local read = file:read("*all")
	file:close()
	return read
end

function file.Write(filename, text)
	local file = assert(io.open("sys/lua/".. filename, "w"))
	file:write(text)
	file:close()
end

function file.Lines(filename)
	if not file.Exists(filename) then return {} end
	local file = assert(io.open("sys/lua/".. filename, "r"))
	return file:lines()
end

function file.Size(filename)
	if not file.Exists(filename) then return 0 end
	local file = assert(io.open("sys/lua/".. filename, "r"))
	local current = file:seek()
	local size = file:seek("end")
	file:seek("set", current)
	file:close()
	return size
end

function file.Rename(oldname, newname)
	if not file.Exists("sys/lua/".. oldname) then return end
	if file.Exists("sys/lua/".. newname) then return end
	os.rename("sys/lua/".. oldname, "sys/lua/".. newname)
end

function file.Delete(filename)
	if not file.Exists(filename) then return end
	os.remove("sys/lua/".. filename)
end
