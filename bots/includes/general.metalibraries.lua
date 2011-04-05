
-- Wait
-- id: player id
-- mode: switch to this mode
function fai_wait(id,mode)
	-- check timer
	if vai_timer[id] > 0 then
		-- decrease
		vai_timer[id] = vai_timer[id]-1
	else
		-- switch mode
		vai_mode[id] = mode
	end
end

-- Angle Delta
-- a1: angle 1
-- a2: angle 2
function fai_angledelta(a1,a2)
	local d = (a2 - a1) % 360
	if d <- 180 then d = d + 360 end
	if d > 180 then d = d - 360 end
	return d
end

-- Angle to
-- x1|y1: position 1
-- x2|y2: position 2
function fai_angleto(x1,y1,x2,y2)
	return math.deg(math.atan2(x2 - x1, y1 - y2))
end

-- Checks if table t has element e
-- t: table
-- e: element
function fai_contains(t,e)
	for _, value in pairs(t) do
		if value == e then
			return true
		end
	end
	return false
end

-- Check if player has item in certain slot
-- id: player id
-- slot: slot
function fai_playerslotitems(id,slot)
	local ply = player.GetByID(id)
	for _, wpn in ply:GetWeapons() do
		if wpn:Slot() == slot then
			return true
		end
	end
	return false
end

-- Walk Aim
-- id: player
function fai_walkaim(id)
	local ply = player.GetByID(id)
	local angle = math.deg(math.atan2(ply:Pos().x - vai_px[id], vai_py[id] - ply:Pos().y))
	ai_aim(id, ply:Pos().x + math.sin(math.rad(angle)) * 150, ply:Pos().y - math.cos(math.rad(angle)) * 150)
	if vai_px[id] ~= ply:Pos().x then vai_px[id] = ply:Pos().x end
	if vai_py[id] ~= ply:Pos().y then vai_py[id] = ply:Pos().y end
end

-- Enemies?
-- id1: player 1
-- id2: player 2
function fai_enemies(id1,id2)
	local ply1 = player.GetByID(id)
	local ply2 = player.GetByID(id)
	-- Enemies if teams are different
	if ply1:Team() ~= ply2:Team() then
		return true
	-- Enemies if game mode is deathmatch
	elseif vai_set_gm == 1 then
		return true
	end
	-- Otherwise: No Enemies
	return false
end

-- Get random (living) teammate
-- id1: random mate of this player (player id)
function fai_randommate(id)
	local ply = player.GetByID(id)
	-- Count
	local players = team.GetPlayersLiving(ply:Team())
	-- Get Random
	if #players ~= 0 then
		for _, v in players do
			local randid = players[math.random(1, #players)]:UserID()
			if randid ~= id then
				return v:UserID()
			end
		end
	end
	-- No mate found
	return 0
end