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
	table.insert(hook.Table[event_name], {name = name, func = func})
end

function hook.Remove(event_name, name)
	for k, v in pairs(hook.GetTable()[event_name]) do
		if v.name == name then
			table.remove(hook.GetTable()[event_name], k)
		end
	end
end

function hook.Core.log(text)
	--if string.find(text, "Lua: Adding function '[^*]' to hook '[^*]'") ~= nil then
		--return 1
	--end
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

function hook.Core.buy(id, weapon)
	if hook.GetTable()["buy"] ~= nil then
		for k, v in pairs(hook.GetTable()["buy"]) do
			local r = v.func(player.GetByID(id), weapon)
			if r ~= nil then
				return r
			end
		end
	end
end
addhook("buy","hook.Core.buy")

function hook.Core.walkover(id, iid, type, ain, a, mode)
	if hook.GetTable()["walkover"] ~= nil then
		for k, v in pairs(hook.GetTable()["walkover"]) do
			local r = v.func(player.GetByID(id), iid, type, ain, a, mode)
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
			v.func(player.GetByID(id), iid, type, ain, a, mode)
		end
	end
end
addhook("collect","hook.Core.collect")

function hook.Core.drop(id, iid, type, ain, a, mode, x, y)
	if hook.GetTable()["drop"] ~= nil then
		for k, v in pairs(hook.GetTable()["drop"]) do
			local r = v.func(player.GetByID(id), iid, type, ain, a, mode, x, y)
			if r ~= nil then
				return r
			end
		end
	end
end
addhook("drop","hook.Core.drop")

function hook.Core.select(id, type, mode)
	if hook.GetTable()["select"] ~= nil then
		for k, v in pairs(hook.GetTable()["select"]) do
			v.func(player.GetByID(id), type, mode)
		end
	end
end
addhook("select","hook.Core.select")

function hook.Core.reload(id, mode)
	if hook.GetTable()["reload"] ~= nil then
		for k, v in pairs(hook.GetTable()["reload"]) do
			v.func(player.GetByID(id), mode)
		end
	end
end
addhook("reload","hook.Core.reload")

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

function hook.Core.projectile(id, weapon, x, y)
	if hook.GetTable()["projectile"] ~= nil then
		for k, v in pairs(hook.GetTable()["projectile"]) do
			v.func(player.GetByID(id), weapon, x, y)
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

function hook.Core.movetile(id, x, y)
	if hook.GetTable()["movetile"] ~= nil then
		for k, v in pairs(hook.GetTable()["movetile"]) do
			v.func(player.GetByID(id), x, y)
		end
	end
end
addhook("movetile","hook.Core.movetile")

function hook.Core.hit(id, source, weapon, hpdmg, apdmg)
	if hook.GetTable()["hit"] ~= nil then
		for k, v in pairs(hook.GetTable()["hit"]) do
			local r = v.func(player.GetByID(id), source, weapon, hpdmg, apdmg)
			if r ~= nil then
				return r
			end
		end
	end
end
addhook("hit","hook.Core.hit")

function hook.Core.kill(killer, victim, weapon, x, y)
	if hook.GetTable()["kill"] ~= nil then
		for k, v in pairs(hook.GetTable()["kill"]) do
			v.func(player.GetByID(killer), player.GetByID(victim), weapon, x, y)
		end
	end
end
addhook("kill","hook.Core.kill")

function hook.Core.die(victim, killer, weapon, x, y)
	if hook.GetTable()["die"] ~= nil then
		for k, v in pairs(hook.GetTable()["die"]) do
			local r = v.func(player.GetByID(victim), player.GetByID(killer), weapon, x, y)
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
	if chatcommand.Run(ply, message, false) then return 1 end
	
	if message == "rank" then
		return 0
	end 
	
	if hook.GetTable()["say"] ~= nil then
		for k, v in pairs(hook.GetTable()["say"]) do
			return v.func(ply, message)
		end
	end
end
addhook("say","hook.Core.say")

function hook.Core.sayteam(id, message)
	local ply = player.GetByID(id)
	if chatcommand.Run(ply, message, true) then return 1 end
	
	if message == "rank" then
		return 0
	end 
	
	if hook.GetTable()["sayteam"] ~= nil then
		for k, v in pairs(hook.GetTable()["sayteam"]) do
			return v.func(ply, message)
		end
	end
end
addhook("sayteam","hook.Core.sayteam")

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

function hook.Core.spray(id)
	if hook.GetTable()["spray"] ~= nil then
		for k, v in pairs(hook.GetTable()["spray"]) do
			v.func(player.GetByID(id))
		end
	end
end
addhook("spray","hook.Core.spray")

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

function hook.Core.build(id, type, x, y, mode, objectid)
	if hook.GetTable()["build"] ~= nil then
		for k, v in pairs(hook.GetTable()["build"]) do
			local r = v.func(player.GetByID(id), type, x, y, mode, ents.GetByIndex(objectid))
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

function hook.Core.rcon(cmds, id, ip, port)
	if hook.GetTable()["rcon"] ~= nil then
		for k, v in pairs(hook.GetTable()["rcon"]) do
			local r = v.func(cmds, player.GetByID(id), ip, port)
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
			local r = v.func(ents.GetByIndex(id), damage, player.GetByID(ply))
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
			v.func(ents.GetByIndex(id), player.GetByID(ply))
		end
	end
end
addhook("objectkill","hook.Core.objectkill")
