local meta = CreateMetaTable("Timer")
local _meta = FindMetaTable("Player")

_timer = timer
timer = {}
player.Timer = {}
player.Timer[0] = {}

timer.STOPPED = 0
timer.RUNNING = 1

function timer.IsTimer(ply, name)
	if player.Timer[ply:UserID()][name] == nil then return false
	else return true end
end

function timer.Create(name, delay, reps, func, ...)
	local ply = player.Rcon(0, "0.0.0.0", "36963")
	if timer.IsTimer(ply, name) then
		timer.Destroy(ply, name)
	end
	local Table = CopyMetaTable("Timer")
	Table.Status = timer.STOPPED
	Table.Player = ply
	Table.Name = tostring(name)
	Table.Delay = delay
	Table.Repetitions = reps
	if func ~= nil then Table.Func = func end
	Table.Args = {...}
	player.Timer[0][name] = Table
	Table:Start()
	return Table
end

function _meta:Timer(name, delay, reps, func, ...)
	if timer.IsTimer(self, name) then
		timer.Destroy(self, name)
	end
	local Table = CopyMetaTable("Timer")
	Table.Status = timer.STOPPED
	Table.Player = self
	Table.Name = tostring(name)
	Table.Delay = delay
	Table.Repetitions = reps
	if func ~= nil then Table.Func = func end
	Table.Args = {self, ...}
	player.Timer[self:UserID()][name] = Table
	Table:Start()
	return Table
end

function timer.Start(...)
	local args = {...}
	local ply
	local name
	
	if #args == 1 then
		ply = player.Rcon(0, "0.0.0.0", "36963")
		name = args[1]
	elseif #args == 2 then
		ply = args[1]
		name = args[2]
	end
	
	if type(name) == "string" and #args > 0 then
		if not timer.IsTimer(ply, name) then return false end
		player.Timer[ply:UserID()][name].n = 0
		player.Timer[ply:UserID()][name].Status = timer.RUNNING
		player.Timer[ply:UserID()][name].Last = 0
		return true
	end
	
	return false
end

function meta:Start()
	return timer.Start(self.Player, self.Name)
end

function timer.Toggle(...)
	local args = {...}
	local ply
	local name
	
	if #args == 1 then
		ply = player.Rcon(0, "0.0.0.0", "36963")
		name = args[1]
	elseif #args == 2 then
		ply = args[1]
		name = args[2]
	end
	
	if type(name) == "string" and #args > 0 then
		if timer.IsTimer(ply, name) then
			if player.Timer[ply:UserID()][name].Status == timer.STOPPED then
				return timer.Start(ply, name)
			elseif player.Timer[ply:UserID()][name].Status == timer.RUNNING then
				return timer.Stop(ply, name)
			end
		end
	end
	
	return false
end

function meta:Toggle()
	return timer.Toggle(self.Player, self.Name)
end

function timer.Stop(...)
	local args = {...}
	local ply
	local name
	
	if #args == 1 then
		ply = player.Rcon(0, "0.0.0.0", "36963")
		name = args[1]
	elseif #args == 2 then
		ply = args[1]
		name = args[2]
	end
	
	if type(name) == "string" and #args > 0 then
		if not timer.IsTimer(ply, name) then return false end
		if player.Timer[ply:UserID()][name].Status == timer.RUNNING then
			player.Timer[ply:UserID()][name].Status = timer.STOPPED
			return true
		end
	end
	
	return false
end

function meta:Stop()
	return timer.Stop(self.Player, self.Name)
end

function timer.Destroy(...)
	local args = {...}
	local ply
	local name
	
	if #args == 1 then
		ply = player.Rcon(0, "0.0.0.0", "36963")
		name = args[1]
	elseif #args == 2 then
		ply = args[1]
		name = args[2]
	end
	
	if type(name) == "string" and #args > 0 then
		if not timer.IsTimer(ply, name) then return false end
		player.Timer[ply:UserID()][name] = nil
		return true
	end
	
	return false
end

function meta:Destroy()
	return timer.Destroy(self.Player, self.Name)
end

timer.Remove = timer.Destroy

function meta:Remove()
	return self:Destroy()
end

hook.Add("join", "PlayerTimerJoin", function(ply)
	player.Timer[ply:UserID()] = {}
end)

hook.Add("second", "CheckTimers", function()
	if player.Timer == nil then return end
	for _, a in pairs(player.Timer) do
		for k, v in pairs(a) do
			if v.Status == timer.RUNNING then
				v.Last = v.Last + 1
				
				if not v.Player:Online() then
					v:Destroy()
				elseif v.Last >= v.Delay then
					v.Last = 0
					v.n = v.n + 1 

					local b, e = pcall(v.Func, unpack(v.Args))
					if b == false then
						print("Timer Error: "..tostring(e))
					end
				
					if v.n >= v.Repetitions and v.Repetitions ~= 0 then
						v:Stop()
					end
				end
			end
		end
	end
end)