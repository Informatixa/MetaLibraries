MetaTable = {}
MetaTable.__index = MetaTable.__index

function CreateMetaTable(name)
	local Obj = {}
	setmetatable(Obj, MetaTable)
	MetaTable[name] = Obj
	return Obj
end

function CopyMetaTable(name)
	local obj = {}
	local meta = FindMetaTable(name)
	setmetatable(obj, MetaTable)
	for n, v in pairs(meta) do obj[n] = v end
	return obj
end

function FindMetaTable(name)
	return MetaTable[name]
end

function PrintMessage(type, text)
	text = string.replace(text, "@C", "")
	if type == HUD_PRINTCENTER then
		msg(text .."@C")
	else
		msg(text)
	end
end

function Trigger(name)
	RunConsoleCommand(string.format("trigger %s", name))
end

function Hud(id, txt, pos, align)
	RunConsoleCommand(string.format("hudtxt %s %s %s %d", id, txt, pos.x, pos.y, align))
end

function ClearHud(id)
	RunConsoleCommand(string.format("hudtxt %s \"\" 0 0 %d", id, TEXT_ALIGN_LEFT))
end

function Vector(posX, posY)
	return {x = posX, y = posY}
end

function tobool(val)
	if val == nil or val == false or val == 0 or val == "0" or val == "false" or val == "" then return false end
	return true
end

function empty(val)
	if val == nil or val == "" then return true end
	return false
end
