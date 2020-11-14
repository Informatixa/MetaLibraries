local enum_print_type = import(METALIBDIR ..'/enum/print_types.lua')
local enum_text_align = import(METALIBDIR ..'/enum/text_align.lua')
local ext_string = import(METALIBDIR ..'/extensions/string.lua')

MetaLibrariesConst.MetaTable = {}

local function pif(public, name, path)	
	local private = {}
	
	function public.CreateMetaTable(name)
		local Obj = {}
		setmetatable(Obj, MetaLibrariesConst.MetaTable)
		MetaLibrariesConst.MetaTable[name] = Obj
		return Obj
	end

	function public.CopyMetaTable(name)
		local obj = {}
		local meta = public.FindMetaTable(name)
		setmetatable(obj, MetaLibrariesConst.MetaTable)
		for n, v in pairs(meta) do obj[n] = v end
		return obj
	end

	function public.FindMetaTable(name)
		return MetaLibrariesConst.MetaTable[name]
	end

	function public.PrintMessage(type, text)
		text = string.gsub(text, '@C', '')
		if type == enum_print_type.HUD_PRINTCENTER then
			msg(text ..'@C')
		else
			msg(text)
		end
	end
	
	function public.ChatPrint(text)
		text = string.gsub(text, '@C', '')
		msg(text)
	end

	function public.Trigger(name)
		parse(string.format('trigger "%s"', name))
	end

	function public.Hud(id, txt, pos, align)
		parse(string.format('hudtxt %d "%s" %d %d %d', id, txt, pos.x, pos.y, align))
	end

	function public.ClearHud(id)
		parse(string.format('hudtxt %d "" 0 0 %d', id, enum_text_align.TEXT_ALIGN_LEFT))
	end

	function public.Vector(posX, posY)
		return {x = posX, y = posY}
	end

	function public.tobool(val)
		if val == true then return true end
		if val == nil or val == false or val == 0 or ext_string.trim(val) == '0' or ext_string.trim(val) == 'false' or ext_string.trim(val) == '' then return false end
		return true
	end

	function public.empty(val)
		if val == nil or ext_string.trim(val) == '' then return true end
		return false
	end
end

return pif