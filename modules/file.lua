local ext_string = import(METALIBDIR ..'/extensions/string.lua')

local function pif(public, name, path)	
	local private = {}

	function public.Exists(filename)
		local file = io.open(filename)
		if file then
			io.close(file)
			return true
		else
			return false
		end
	end

	function public.Read(filename)
		if not public.Exists(filename) then return '' end
		local file = assert(io.open(filename, 'r+'))
		local read = file:read('*all')
		file:close()
		return read
	end

	function public.Find(dir)
		dir = string.gsub(dir, '/', '\\')
		local files = {}
		for i in io.popen('dir '.. dir):lines() do
			local filename = ext_string.trim(string.sub(i, 37))
			if string.len(filename) > 0 then
				table.insert(files, filename)
			end
		end
		table.remove(files, 1)
		table.remove(files, 1)
		table.remove(files, 1)
		table.remove(files, #files)
		table.remove(files, #files)
		return files
	end

	function public.Write(filename, text, mode)
		if mode == nil or (mode ~= 'w' and mode ~= 'w+' and mode ~= 'a' and mode ~= 'a+') then mode = 'w' end
		local file = assert(io.open(filename, mode))
		file:write(text)
		file:close()
	end

	function public.Lines(filename)
		if not public.Exists(filename) then return {} end
		local file = assert(io.open(filename, 'r+'))
		return file:lines()
	end

	function public.Size(filename)
		if not public.Exists(filename) then return 0 end
		local file = assert(io.open(filename, 'r+'))
		local current = file:seek()
		local size = file:seek('end')
		file:seek('set', current)
		file:close()
		return size
	end

	function public.Rename(oldname, newname)
		if not public.Exists(oldname) then return end
		if public.Exists(newname) then return end
		os.rename(oldname, newname)
	end

	function public.Delete(filename)
		if not public.Exists(filename) then return end
		os.remove(filename)
	end
end

return pif