hook = {}
hook.Table = {}
hook.Core = {}

function hook.GetTable()
	return hook.Table
end

function hook.Add(event_name, name, func)
	if hook.Table[event_name] == nil then
		hook.Table[event_name] = {}
	end
	
	if event_name == "serveraction" then
		hook.GetTable()[event_name][name] = func
	else
		table.insert(hook.Table[event_name], {name = name, func = func})
	end
end

function hook.Remove(event_name, name)
	if event_name == "serveraction" then
		hook.GetTable()[event_name][name] = function() end
	else
		for k, v in pairs(hook.GetTable()[event_name]) do
			if v.name == name then
				table.remove(hook.GetTable()[event_name], k)
			end
		end
	end
end

function hook.Core.log(text)
	if hook.GetTable()["log"] ~= nil then
		for k, v in pairs(hook.GetTable()["log"]) do
			local r = v.func(text)
			if r ~= nil then
				return r
			end
		end
	end
end
addhook("log","hook.Core.log")

function hook.Core.ms100()
	if hook.GetTable()["ms100"] ~= nil then
		for k, v in pairs(hook.GetTable()["ms100"]) do
			v.func()
		end
	end
end
addhook("ms100","hook.Core.ms100")

function hook.Core.second()
	if hook.GetTable()["second"] ~= nil then
		for k, v in pairs(hook.GetTable()["second"]) do
			v.func()
		end
	end
end
addhook("second","hook.Core.second")

function hook.Core.minute()
	if hook.GetTable()["minute"] ~= nil then
		for k, v in pairs(hook.GetTable()["minute"]) do
			v.func()
		end
	end
end
addhook("minute","hook.Core.minute")

function hook.Core.always()
	if hook.GetTable()["always"] ~= nil then
		for k, v in pairs(hook.GetTable()["always"]) do
			v.func()
		end
	end
end
addhook("always","hook.Core.always")

function hook.Core.join(id)
	player.GetByID(id):PrintMessage(HUD_PRINTCENTER, "�000128128The server uses the module MetaLibraries developed by MetaStudios.")
	
	if hook.GetTable()["join"] ~= nil then
		for k, v in pairs(hook.GetTable()["join"]) do
			v.func(player.GetByID(id))
		end
	end
end
addhook("join","hook.Core.join")

function hook.Core.leave(id, reason)
	if hook.GetTable()["leave"] ~= nil then
		for k, v in pairs(hook.GetTable()["leave"]) do
			v.func(player.GetByID(id), reason)
		end
	end
end
addhook("leave","hook.Core.leave")

function hook.Core.team(id, team, look)
	if hook.GetTable()["team"] ~= nil then
		for k, v in pairs(hook.GetTable()["team"]) do
			local r = v.func(player.GetByID(id), team, look)
			if r ~= nil then
				return r
			end
		end
	end
end
addhook("team","hook.Core.team")

function hook.Core.spawn(id)
	if hook.GetTable()["spawn"] ~= nil then
		for k, v in pairs(hook.GetTable()["spawn"]) do
			local r = v.func(player.GetByID(id))
			if r ~= nil then
				return r
			end
		end
	end
end
addhook("spawn","hook.Core.spawn")

--[[function ai_respawn(id)
	if hook.GetTable()["ai_respawn"] ~= nil then
		for k, v in pairs(hook.GetTable()["ai_respawn"]) do
			v.func(player.GetByID(id))
		end
	end
end--]]

function hook.Core.startround(mode)
	if hook.GetTable()["startround"] ~= nil then
		for k, v in pairs(hook.GetTable()["startround"]) do
			v.func(mode)
		end
	end
end
addhook("startround","hook.Core.startround")

function hook.Core.endround(mode)
	if hook.GetTable()["endround"] ~= nil then
		for k, v in pairs(hook.GetTable()["endround"]) do
			v.func(mode)
		end
	end
end
addhook("endround","hook.Core.endround")

function hook.Core.name(id, oldname, newname)
	if hook.GetTable()["name"] ~= nil then
		for k, v in pairs(hook.GetTable()["name"]) do
			local r = v.func(player.GetByID(id), oldname, newname)
			if r ~= nil then
				return r
			end
		end
	end
end
addhook("name","hook.Core.name")

function hook.Core.mapchange(newmap)
	if hook.GetTable()["mapchange"] ~= nil then
		for k, v in pairs(hook.GetTable()["mapchange"]) do
			v.func(newmap)
		end
	end
end
addhook("mapchange","hook.Core.mapchange")

function hook.Core.serveraction(id, action)
	if hook.GetTable()["serveraction"] ~= nil then
		if action == 1 then
			if hook.GetTable()["serveraction"]["f2"] ~= nil then
				hook.GetTable()["serveraction"]["f2"](player.GetByID(id))
			end
		elseif action == 2 then
			if hook.GetTable()["serveraction"]["f3"] ~= nil then
				hook.GetTable()["serveraction"]["f3"](player.GetByID(id))
			end
		elseif action == 3 then
			if hook.GetTable()["serveraction"]["f4"] ~= nil then
				hook.GetTable()["serveraction"]["f4"](player.GetByID(id))
			end
		end
	end
end
addhook("serveraction","hook.Core.serveraction")

function hook.Core.trigger(trigger, source)
	if hook.GetTable()["trigger"] ~= nil then
		for k, v in pairs(hook.GetTable()["trigger"]) do
			local r = v.func(trigger, source)
			if r ~= nil then
				return r
			end
		end
	end
end
addhook("trigger","hook.Core.trigger")

function hook.Core.triggerentity(x, y)
	if hook.GetTable()["triggerentity"] ~= nil then
		for k, v in pairs(hook.GetTable()["triggerentity"]) do
			local r = v.func(x, y)
			if r ~= nil then
				return r
			end
		end
	end
end
addhook("triggerentity","hook.Core.triggerentity")

function hook.Core.buy(id, wpn)
	if hook.GetTable()["buy"] ~= nil then
		for k, v in pairs(hook.GetTable()["buy"]) do
			local r = v.func(player.GetByID(id), weapon.GetByType(wpn))
			if r ~= nil then
				return r
			end
		end
	end
end
addhook("buy","hook.Core.buy")

--[[function ai_buy(id, wpn)
	if hook.GetTable()["ai_buy"] ~= nil then
		for k, v in pairs(hook.GetTable()["ai_buy"]) do
			local r = v.func(player.GetByID(id), weapon.GetByType(wpn))
			if r ~= nil then
				return r
			end
		end
	end
end--]]

function hook.Core.walkover(id, iid, type, ain, a, mode)
	if hook.GetTable()["walkover"] ~= nil then
		for k, v in pairs(hook.GetTable()["walkover"]) do
			local r = v.func(player.GetByID(id), item.GetByID(iid), type, ain, a, mode)
			if r ~= nil then
				return r
			end
		end
	end
end
addhook("walkover","hook.Core.walkover")

function hook.Core.collect(id, iid, type, ain, a, mode)
	if hook.GetTable()["collect"] ~= nil then
		for k, v in pairs(hook.GetTable()["collect"]) do
			v.func(player.GetByID(id), item.GetByID(iid), type, ain, a, mode)
		end
	end
end
addhook("collect","hook.Core.collect")

function hook.Core.drop(id, iid, type, ain, a, mode, x, y)
	if hook.GetTable()["drop"] ~= nil then
		for k, v in pairs(hook.GetTable()["drop"]) do
			local r = v.func(player.GetByID(id), item.GetByID(iid), type, ain, a, mode, x, y)
			if r ~= nil then
				return r
			end
		end
	end
end
addhook("drop","hook.Core.drop")

--[[function ai_drop(id)
	if hook.GetTable()["ai_drop"] ~= nil then
		for k, v in pairs(hook.GetTable()["ai_drop"]) do
			v.func(player.GetByID(id))
		end
	end
end--]]

function hook.Core.select(id, type, mode)
	if hook.GetTable()["select"] ~= nil then
		for k, v in pairs(hook.GetTable()["select"]) do
			v.func(player.GetByID(id), weapon.GetByType(type), mode)
		end
	end
end
addhook("select","hook.Core.select")

--[[function ai_selectweapon(id, type)
	if hook.GetTable()["ai_selectweapon"] ~= nil then
		for k, v in pairs(hook.GetTable()["ai_selectweapon"]) do
			v.func(player.GetByID(id), weapon.GetByType(type))
		end
	end
end--]]

function hook.Core.reload(id)
	if hook.GetTable()["reload"] ~= nil then
		for k, v in pairs(hook.GetTable()["reload"]) do
			v.func(player.GetByID(id))
		end
	end
end
addhook("reload","hook.Core.reload")

--[[function ai_reload(id)
	if hook.GetTable()["ai_reload"] ~= nil then
		for k, v in pairs(hook.GetTable()["ai_reload"]) do
			v.func(player.GetByID(id), mode)
		end
	end
end--]]

function hook.Core.attack(id)
	if hook.GetTable()["attack"] ~= nil then
		for k, v in pairs(hook.GetTable()["attack"]) do
			v.func(player.GetByID(id))
		end
	end
end
addhook("attack","hook.Core.attack")

function hook.Core.attack2(id, mode)
	if hook.GetTable()["attack2"] ~= nil then
		for k, v in pairs(hook.GetTable()["attack2"]) do
			v.func(player.GetByID(id), mode)
		end
	end
end
addhook("attack2","hook.Core.attack2")

--[[function ai_attack(id, secondary)
	if tobool(secondary) then
		if hook.GetTable()["ai_attack2"] ~= nil then
			for k, v in pairs(hook.GetTable()["ai_attack2"]) do
				v.func(player.GetByID(id))
			end
		end
	else
		if hook.GetTable()["ai_attack"] ~= nil then
			for k, v in pairs(hook.GetTable()["ai_attack"]) do
				v.func(player.GetByID(id))
			end
		end
	end
end--]]

function hook.Core.projectile(id, wpn, x, y)
	if hook.GetTable()["projectile"] ~= nil then
		for k, v in pairs(hook.GetTable()["projectile"]) do
			v.func(player.GetByID(id), weapon.GetByType(wpn), x, y)
		end
	end
end
addhook("projectile","hook.Core.projectile")

function hook.Core.move(id, x, y, walk)
	if hook.GetTable()["move"] ~= nil then
		for k, v in pairs(hook.GetTable()["move"]) do
			v.func(player.GetByID(id), x, y, walk)
		end
	end
end
addhook("move","hook.Core.move")

--[[function ai_move(id, angle, walk)
	if hook.GetTable()["ai_move"] ~= nil then
		for k, v in pairs(hook.GetTable()["ai_move"]) do
			v.func(player.GetByID(id), angle, walk)
		end
	end
end--]]

function hook.Core.movetile(id, x, y)
	if hook.GetTable()["movetile"] ~= nil then
		for k, v in pairs(hook.GetTable()["movetile"]) do
			v.func(player.GetByID(id), x, y)
		end
	end
end
addhook("movetile","hook.Core.movetile")

function hook.Core.hit(id, source, wpn, hpdmg, apdmg)
	if hook.GetTable()["hit"] ~= nil then
		for k, v in pairs(hook.GetTable()["hit"]) do
			local r = v.func(player.GetByID(id), player.GetByID(source), weapon.GetByType(wpn), hpdmg, apdmg)
			if r ~= nil then
				return r
			end
		end
	end
end
addhook("hit","hook.Core.hit")

function hook.Core.kill(killer, victim, wpn, x, y)
	if hook.GetTable()["kill"] ~= nil then
		for k, v in pairs(hook.GetTable()["kill"]) do
			v.func(player.GetByID(killer), player.GetByID(victim), weapon.GetByType(wpn), x, y)
		end
	end
end
addhook("kill","hook.Core.kill")

function hook.Core.die(victim, killer, wpn, x, y)
	if hook.GetTable()["die"] ~= nil then
		for k, v in pairs(hook.GetTable()["die"]) do
			local r = v.func(player.GetByID(victim), player.GetByID(killer), weapon.GetByType(wpn), x, y)
			if r ~= nil then
				return r
			end
		end
	end
end
addhook("die","hook.Core.die")

function hook.Core.breaks(x, y)
	if hook.GetTable()["break"] ~= nil then
		for k, v in pairs(hook.GetTable()["break"]) do
			v.func(x, y)
		end
	end
end
addhook("break","hook.Core.breaks")

function hook.Core.use(id, event, data, x, y)
	if hook.GetTable()["use"] ~= nil then
		for k, v in pairs(hook.GetTable()["use"]) do
			v.func(player.GetByID(id), event, data, x, y)
		end
	end
end
addhook("use","hook.Core.use")

--[[function ai_use(id)
	if hook.GetTable()["ai_use"] ~= nil then
		for k, v in pairs(hook.GetTable()["ai_use"]) do
			v.func(player.GetByID(id))
		end
	end
end--]]

function hook.Core.usebutton(id, x, y)
	if hook.GetTable()["usebutton"] ~= nil then
		for k, v in pairs(hook.GetTable()["usebutton"]) do
			v.func(player.GetByID(id), x, y)
		end
	end
end
addhook("usebutton","hook.Core.usebutton")

function hook.Core.say(id, message)
	local ply = player.GetByID(id)
	if chatcommand.Run(ply, message, false) then return HOOK_NOSAY end
	
	if message == "rank" then
		return HOOK_SAY
	end 
	
	if hook.GetTable()["say"] ~= nil then
		for k, v in pairs(hook.GetTable()["say"]) do
			local r = v.func(ply, message)
			if r ~= nil then
				return r
			end
		end
	end
end
addhook("say","hook.Core.say")

--[[function ai_say(id, message)
	local ply = player.GetByID(id)

	if hook.GetTable()["ia_say"] ~= nil then
		for k, v in pairs(hook.GetTable()["ia_say"]) do
			v.func(ply, message)
		end
	end
end--]]

function hook.Core.sayteam(id, message)
	local ply = player.GetByID(id)
	if chatcommand.Run(ply, message, true) then return HOOK_NOSAYTEAM end
	
	if message == "rank" then
		return HOOK_SAYTEAM
	end 
	
	if hook.GetTable()["sayteam"] ~= nil then
		for k, v in pairs(hook.GetTable()["sayteam"]) do
			local r = v.func(ply, message)
			if r ~= nil then
				return r
			end
		end
	end
end
addhook("sayteam","hook.Core.sayteam")

--[[function ai_sayteam(id, message)
	local ply = player.GetByID(id)

	if hook.GetTable()["ai_sayteam"] ~= nil then
		for k, v in pairs(hook.GetTable()["ai_sayteam"]) do
			v.func(ply, message)
		end
	end
end--]]

function hook.Core.radio(id, message)
	if hook.GetTable()["radio"] ~= nil then
		for k, v in pairs(hook.GetTable()["radio"]) do
			local r = v.func(player.GetByID(id), message)
			if r ~= nil then
				return r
			end
		end
	end
end
addhook("radio","hook.Core.radio")

--[[function ai_radio(id, message)
	if hook.GetTable()["ai_radio"] ~= nil then
		for k, v in pairs(hook.GetTable()["ai_radio"]) do
			v.func(player.GetByID(id), message)
		end
	end
end--]]

function hook.Core.spray(id)
	if hook.GetTable()["spray"] ~= nil then
		for k, v in pairs(hook.GetTable()["spray"]) do
			v.func(player.GetByID(id))
		end
	end
end
addhook("spray","hook.Core.spray")

--[[function ai_spray(id)
	if hook.GetTable()["ai_spray"] ~= nil then
		for k, v in pairs(hook.GetTable()["ai_spray"]) do
			v.func(player.GetByID(id))
		end
	end
end--]]

function hook.Core.vote(id, mode, param)
	if hook.GetTable()["vote"] ~= nil then
		for k, v in pairs(hook.GetTable()["vote"]) do
			v.func(player.GetByID(id), mode, param)
		end
	end
end
addhook("vote","hook.Core.vote")

function hook.Core.buildattempt(id, type, x, y)
	if hook.GetTable()["buildattempt"] ~= nil then
		for k, v in pairs(hook.GetTable()["buildattempt"]) do
			local r = v.func(player.GetByID(id), type, x, y)
			if r ~= nil then
				return r
			end
		end
	end
end
addhook("buildattempt","hook.Core.buildattempt")

--[[function ai_build(id, type, x, y)
	if hook.GetTable()["ai_build"] ~= nil then
		for k, v in pairs(hook.GetTable()["ai_build"]) do
			v.func(player.GetByID(id), type, x, y)
		end
	end
end--]]

function hook.Core.build(id, type, x, y, mode, objectid)
	if hook.GetTable()["build"] ~= nil then
		for k, v in pairs(hook.GetTable()["build"]) do
			local r = v.func(player.GetByID(id), type, x, y, mode, object.GetByID(objectid))
			if r ~= nil then
				return r
			end
		end
	end
end
addhook("build","hook.Core.build")

function hook.Core.flagtake(id, team, x, y)
	if hook.GetTable()["flagtake"] ~= nil then
		for k, v in pairs(hook.GetTable()["flagtake"]) do
			local r = v.func(player.GetByID(id), team, x, y)
			if r ~= nil then
				return r
			end
		end
	end
end
addhook("flagtake","hook.Core.flagtake")

function hook.Core.flagcapture(id, team, x, y)
	if hook.GetTable()["flagcapture"] ~= nil then
		for k, v in pairs(hook.GetTable()["flagcapture"]) do
			local r = v.func(player.GetByID(id), team, x, y)
			if r ~= nil then
				return r
			end
		end
	end
end
addhook("flagcapture","hook.Core.flagcapture")

function hook.Core.dominate(id, team, x, y)
	if hook.GetTable()["dominate"] ~= nil then
		for k, v in pairs(hook.GetTable()["dominate"]) do
			local r = v.func(player.GetByID(id), team, x, y)
			if r ~= nil then
				return r
			end
		end
	end
end
addhook("dominate","hook.Core.dominate")


function hook.Core.bombplant(id, x, y)
	if hook.GetTable()["bombplant"] ~= nil then
		for k, v in pairs(hook.GetTable()["bombplant"]) do
			local r = v.func(player.GetByID(id), x, y)
			if r ~= nil then
				return r
			end
		end
	end
end
addhook("bombplant","hook.Core.bombplant")


function hook.Core.bombdefuse(id)
	if hook.GetTable()["bombdefuse"] ~= nil then
		for k, v in pairs(hook.GetTable()["bombdefuse"]) do
			local r = v.func(player.GetByID(id))
			if r ~= nil then
				return r
			end
		end
	end
end
addhook("bombdefuse","hook.Core.bombdefuse")


function hook.Core.bombexplode(id, x, y)
	if hook.GetTable()["bombexplode"] ~= nil then
		for k, v in pairs(hook.GetTable()["bombexplode"]) do
			local r = v.func(player.GetByID(id), x, y)
			if r ~= nil then
				return r
			end
		end
	end
end
addhook("bombexplode","hook.Core.bombexplode")


function hook.Core.hostagerescue(id, x, y)
	if hook.GetTable()["hostagerescue"] ~= nil then
		for k, v in pairs(hook.GetTable()["hostagerescue"]) do
			v.func(player.GetByID(id), x, y)
		end
	end
end
addhook("hostagerescue","hook.Core.hostagerescue")


function hook.Core.vipescape(id, x, y)
	if hook.GetTable()["vipescape"] ~= nil then
		for k, v in pairs(hook.GetTable()["vipescape"]) do
			v.func(player.GetByID(id), x, y)
		end
	end
end
addhook("vipescape","hook.Core.vipescape")

function hook.Core.menu(id, title, button)
	if hook.GetTable()["menu"] ~= nil then
		for k, v in pairs(hook.GetTable()["menu"]) do
			v.func(player.GetByID(id), title, button)
		end
	end
end
addhook("menu","hook.Core.menu")

function hook.Core.rcon(message, id, ip, port)
	if hook.GetTable()["rcon"] ~= nil then
		local cmd = string.explode(" ", message)[1]
		local args = string.explode(" ", message:sub(cmd:len() + 2))
			
		for k, v in pairs(hook.GetTable()["rcon"]) do
			local r = v.func(player.Rcon(id, ip, port), cmd, args)
			if r ~= nil then
				return r
			end
		end
	end
end
addhook("rcon","hook.Core.rcon")

function hook.Core.objectdamage(id, damage, ply)
	if hook.GetTable()["objectdamage"] ~= nil then
		for k, v in pairs(hook.GetTable()["objectdamage"]) do
			local r = v.func(object.GetByID(id), damage, player.GetByID(ply))
			if r ~= nil then
				return r
			end
		end
	end
end
addhook("objectdamage","hook.Core.objectdamage")

function hook.Core.objectkill(id, ply)
	if hook.GetTable()["objectkill"] ~= nil then
		for k, v in pairs(hook.GetTable()["objectkill"]) do
			v.func(object.GetByID(id), player.GetByID(ply))
		end
	end
end
addhook("objectkill","hook.Core.objectkill")

function hook.Core.parse(text)
	if hook.GetTable()["parse"] ~= nil then
		local cmd = string.explode(" ", text)[1]
		local args = string.explode(" ", text:sub(cmd:len() + 2))
		
		for k, v in pairs(hook.GetTable()["parse"]) do
			local r = v.func(cmd, args)
			if r ~= nil then
				return r
			end
		end
	end
end
addhook("parse","hook.Core.parse")

--[[function ai_rotate(id, angle)
	if hook.GetTable()["ai_rotate"] ~= nil then
		for k, v in pairs(hook.GetTable()["ai_rotate"]) do
			v.func(player.GetByID(id), angle)
		end
	end
end

function ai_goto(id, x, y, walk)
	if hook.GetTable()["ai_goto"] ~= nil then
		for k, v in pairs(hook.GetTable()["ai_goto"]) do
			v.func(player.GetByID(id), x, y, walk)
		end
	end
end

function ai_debug(id, text)
	if hook.GetTable()["ai_debug"] ~= nil then
		for k, v in pairs(hook.GetTable()["ai_debug"]) do
			v.func(player.GetByID(id), text)
		end
	end
end

function ai_iattack(id)
	if hook.GetTable()["ai_iattack"] ~= nil then
		for k, v in pairs(hook.GetTable()["ai_iattack"]) do
			v.func(player.GetByID(id))
		end
	end
end

function ai_aim(id, x, y)
	if hook.GetTable()["ai_aim"] ~= nil then
		for k, v in pairs(hook.GetTable()["ai_aim"]) do
			v.func(player.GetByID(id), x, y)
		end
	end
end

function ai_freeline(id, x, y)
	if hook.GetTable()["ai_freeline"] ~= nil then
		for k, v in pairs(hook.GetTable()["ai_freeline"]) do
			v.func(player.GetByID(id), x, y)
		end
	end
end

function ai_findtarget(id)
	if hook.GetTable()["ai_findtarget"] ~= nil then
		for k, v in pairs(hook.GetTable()["ai_findtarget"]) do
			v.func(player.GetByID(id))
		end
	end
end--]]

function hook.Core.clientdata(id, mode, data1, data2)
	if hook.GetTable()["clientdata"] ~= nil then
		for k, v in pairs(hook.GetTable()["clientdata"]) do
			local r = v.func(player.GetByID(id), mode, data1, data2)
			if r ~= nil then
				return r
			end
		end
	end
end
addhook("clientdata","hook.Core.clientdata")

function hook.Core.objectupgrade(id, ply, progress, total)
	if hook.GetTable()["objectupgrade"] ~= nil then
		for k, v in pairs(hook.GetTable()["objectupgrade"]) do
			local r = v.func(object.GetByID(id), player.GetByID(ply), progress, total)
			if r ~= nil then
				return r
			end
		end
	end
end
addhook("objectupgrade","hook.Core.objectupgrade")
