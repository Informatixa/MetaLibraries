
-- Engage Enemies
function fai_engage(id)
	local ply = player.GetByID(id)
	
	-- Find Target
	vai_reaim[id] = vai_reaim[id] - 1
	if vai_reaim[id] < 0 then
		vai_reaim[id] = 20
		vai_target[id] = ai_findtarget(id)
		if vai_target[id] > 0 then
			vai_rescan[id] = 0
		end
	end
	
	-- Target in Sight?
	if vai_target[id] > 0 then
		local target = player.GetByID(id)
		
		if ply ~= nil then
			if target:Health() > 0 and target:Team() > 0 and fai_enemies(vai_target[id],id)==true then
				-- Cache Positions
				local x1=ply:Pos().x
				local y1=ply:Pos().y
				local x2=target:Pos().x
				local y2=target:Pos().y
				-- In Range?
				if math.abs(x1-x2)<315 and math.abs(y1-y2)<235 then
					-- Freeline Scan
					vai_rescan[id]=vai_rescan[id]-1
					if vai_rescan[id]<0 then
						vai_rescan[id]=10
						if math.abs(x1-x2)>30 or math.abs(y1-y2)>30 then 
							if not ai_freeline(id,x2,y2) then
								vai_target[id]=0
							end
						end
					end
				else
					vai_target[id]=0
				end
			else
				vai_target[id]=0
			end
		else
			vai_target[id]=0
		end
	end
	
	-- Aim
	if vai_target[id] > 0 then
		vai_aimx[id] = target:Pos().x
		vai_aimy[id] = target:Pos().y
		-- Switch to Fight Mode
		if vai_mode[id]~=4 and vai_mode[id]~=5 then
			vai_timer[id]=math.random(25,100)
			vai_smode[id]=math.random(0,360)
			vai_mode[id]=4
		end
	end
	ai_aim(id,vai_aimx[id],vai_aimy[id])
	
	-- Attack
	if vai_target[id]>0 then
		-- Right Direction?
		if math.abs(fai_angledelta(tonumber(ply:Angle()),fai_angleto(ply:Pos().x,ply:Pos().y,target:Pos().x,target:Pos().y)))<15 then
			-- "Intelligent" Attack (automatic weapon selection and reloading)
			ai_iattack(id)
		end
	end

end