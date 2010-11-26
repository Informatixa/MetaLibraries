chatcommand = {}
chatcommand.Table = {}

function chatcommand.GetTable()
	return chatcommand.Table
end

function chatcommand.Add(name, func)
	chatcommand.Table[name:lower()] = func
end

function chatcommand.Remove(name)
	chatcommand.Table[name:lower()] = nil
end

function chatcommand.Run(ply, message, sayteam)
	local cmd = string.replace(string.explode(" ", message)[1], "!", "")
	local args = string.explode(" ", message:sub(cmd:len() + 3))
	
	if message:sub(1, 1) == "!" then
		if cmd == "credit" then
			ply:PrintMessage(HUD_PRINTCENTER, "©255255000Programing by")
			ply:PrintMessage(HUD_PRINTCENTER, "©050150255Informatixa and MetaStudios Team")
			return true
		end
		
		for _, v in pairs(args) do
			if empty(v) then
				ply:ChatPrint("©255255000The argument is null!")
				return true
			end
		end
		
		for k, v in pairs(chatcommand.Table) do
			if (cmd == k) then
				v(ply, args, sayteam)
				return true
			end
		end
		
		return true
	end
	
	return false
end

comcommand = {}
comcommand.Table = {}

function comcommand.GetTable()
	return comcommand.Table
end

function comcommand.Add(name, func)
	comcommand.Table[name:lower()] = func
end

function comcommand.Remove(name)
	comcommand.Table[name:lower()] = nil
end

function comcommand.Run(cmd, args)
	if comcommand.Table[cmd:lower()] ~= nil then
		comcommand.Table[cmd:lower()](args)
		return true
	else
		return false
	end
end

hook.Add("parse", "ConCommand", function(cmd, args)
	if comcommand.Run(cmd, args) then return HOOK_NOPARSE else return HOOK_PARSE end
end)
