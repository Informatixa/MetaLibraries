MetaTable = {}
MetaTable.__index = MetaTable.__index

function CreateMetaTable(name)
	local Obj = {}
	setmetatable(Obj, MetaTable)
	MetaTable[name] = Obj
	return Obj
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

function Hud(id, txt, pos, align)
	RunConsoleCommand("hudtxt ".. id .." \"".. txt .."\" ".. pos.x .." ".. pos.y .." ".. align)
end

function ClearHud(id)
	RunConsoleCommand("hudtxt ".. id .." \"\" 0 0 ".. TEXT_ALIGN_LEFT)
end

function Vector(posX, posY)
	return {x = posX, y = posY}
end

function tobool(val)
	if val == nil or val == false or val == 0 or val == "0" or val == "false" or val == "" then return false end
	return true
end