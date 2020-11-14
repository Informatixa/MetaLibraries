local imported = {}

local function package_stub(name)
	local stub = {}
	local stub_meta = {
		__index = function(_, index)
			error(string.format("member `%s' is accessed before package `%s' is fully imported", index, name))
		end,
		__newindex = function(_, index, _)
			error(string.format("member `%s' is assigned a value before package `%s' is fully imported", index, name))
		end,
	}
	setmetatable(stub, stub_meta)
	return stub
end

local function lock_stub(stub)
	local meta = getmetatable(stub)
	meta.__metatable = false
	return meta
end

local function unlock_stub(stub, meta)
	meta.__metatable = nil
	setmetatable(stub, nil)
end

local function locate(path)
	local chunk = loadfile(path)
	if chunk then return chunk, path end
	return nil, path
end

local function _import(name)
	local package = imported[name]
	if package then return package end
	local chunk, path = locate(name)
	if not chunk then
		error(string.format("could not locate package `%s' in `%s'", name, path))
	end
	package = package_stub(name)
	imported[name] = package
	--setglobals(chunk, getglobals(2))
	local key = lock_stub(package)
	chunk = chunk()
	unlock_stub(package, key)
	if type(chunk) == "function" then
		chunk(package, name, path)
	end
	return package
end

function import(name)
	return _import(name)
end

--setglobals(import, {__globals = false})