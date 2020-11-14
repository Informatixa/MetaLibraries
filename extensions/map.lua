local ext_object = import(METALIBDIR ..'/extensions/object.lua')
local util = import(METALIBDIR ..'/util.lua')

local function pif(public, name, path)
	local private = {}
	
	function public.GetName()
		return map('name')
	end

	function public.GetSize()
		return util.Vector(map('xsize'), map('ysize'))
	end

	function public.GetVips()
		return map('mission_vips')
	end

	function public.GetHostages()
		return map('mission_hostages')
	end

	function public.GetBombSpots()
		return map('mission_bombspots')
	end

	function public.GetCtfFlags()
		return map('mission_ctfflags')
	end

	function public.GetDomPoints()
		return map('mission_dompoints')
	end

	function public.GetBotNodes()
		return map('botnodes')
	end

	function public.IsNoBuying()
		return map('nobuying')
	end

	function public.IsNoWeapons()
		return map('noweapons')
	end

	function public.GetTeleporters()
		return map('teleporters')
	end

	function public.InEntity(tilex, tiley)
		return util.tobool(entity(tilex, tiley, 'exists'))
	end

	function public.InObject(tilex, tiley)
		if ext_object.GetByPos(tilex, tiley) ~= nil then
			return true
		else
			return false
		end
	end
end

return pif