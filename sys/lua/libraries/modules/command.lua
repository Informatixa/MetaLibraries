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
	local args = string.explode(" ", message:sub(cmd:len() + 1))
	
	if message:sub(1, 1) == "!" then
		if cmd == "credit" then
			ply.PrintMessage(HUD_PRINTCENTER, "©255255000Programing by")
			ply.PrintMessage(HUD_PRINTCENTER, "©050150255Informatixa and MetaGamerz Team")
			return true
		end
		
		for _, v in pairs(args) do
			if v == nil or v == "" then
				ply.ChatPrint("©255255000The argument is null!")
				return true
			end
		end
		
		if ply:IsAdmin() then
			for k, v in pairs(chatcommand.Table) do
				if (cmd == k) then
					v(ply, args, sayteam)
					return true
				end
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

function comcommand.Parse(text)
	local cmd = string.explode(" ", text)[1]
	local args = string.explode(" ", text:sub(cmd:len() + 1))
	if comcommand.Run(cmd, args) then return 2 else return 0 end
end
addhook("parse", "comcommand.Parse")