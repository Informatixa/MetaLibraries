MetaLibrariesConst.HookTable = {}

local function pif(public, name, path)	
	local private = {}
	
	function private.GetTable()
		return MetaLibrariesConst.HookTable
	end

	function public.Add(event_name, name, func)
		local HookTable = private.GetTable()
		
		if HookTable[event_name] == nil then
			HookTable[event_name] = {}
		end
		
		if event_name == "serveraction" then
			HookTable[event_name][name] = func
		else
			table.insert(HookTable[event_name], {name = name, func = func})
		end
	end

	function public.Remove(event_name, name)
		local HookTable = private.GetTable()
		
		if event_name == "serveraction" then
			HookTable[event_name][name] = function() end
		else
			for k, v in pairs(HookTable[event_name]) do
				if v.name == name then
					table.remove(HookTable[event_name], k)
				end
			end
		end
	end
end

return pif