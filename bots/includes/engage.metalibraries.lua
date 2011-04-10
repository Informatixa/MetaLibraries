
-- Engage Enemies
function fai_engage(id)

	-- Find Target
	vai_reaim[id]=vai_reaim[id]-1
	if vai_reaim[id]<0 then
		vai_reaim[id]=20
		vai_target[id]=ai_findtarget(id)
		if vai_target[id]>0 then
			vai_rescan[id]=0
		end
	end
	
	-- Target in Sight?
	if vai_target[id]>0 then
		if _player(vai_target[id],"exists") then
			if _player(vai_target[id],"health")>0 and _player(vai_target[id],"team")>0 and fai_enemies(vai_target[id],id)==true then
				-- Cache Positions
				local x1=_player(id,"x")
				local y1=_player(id,"y")
				local x2=_player(vai_target[id],"x")
				local y2=_player(vai_target[id],"y")
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
	if vai_target[id]>0 then
		vai_aimx[id]=_player(vai_target[id],"x")
		vai_aimy[id]=_player(vai_target[id],"y")
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
		if math.abs(fai_angledelta(tonumber(_player(id,"rot")),fai_angleto(_player(id,"x"),_player(id,"y"),_player(vai_target[id],"x"),_player(vai_target[id],"y"))))<15 then
			-- "Intelligent" Attack (automatic weapon selection and reloading)
			ai_iattack(id)
		end
	end

end