--------------------------------------------------
-- CS2D Standard Bot AI                         --
-- 01.08.2010 - www.UnrealSoftware.de           --
--                                              --
-- includes: includes/*                         --
--                                              --
-- Used names in this script                    --
-- vai_ = AI variable                           --
-- fai_ = AI helper function                    --
-- ai_ = AI function (native CS2D Lua AI)       --
--                                              --
-- sys/lua/info.txt contains an AI commandlist! --
--------------------------------------------------

__map = map
__game = game
__player = player
__item = item
__menu = menu
map = _map
game = _game
player = _player
item = _item
menu = _menu

-- Includes
dofile("bots/includes/settings.lua")	-- track settings
dofile("bots/includes/general.lua")		-- general helper functions
dofile("bots/includes/buy.lua")			-- buying
dofile("bots/includes/decide.lua")		-- decision making process
dofile("bots/includes/engage.lua")		-- engage/attack/battle
dofile("bots/includes/collect.lua")		-- item collecting

-- AI Variables (vai_)
vai_set_gm=0					-- Game Mode Setting
vai_set_botskill=0				-- Bot Skill Setting
vai_set_botweapons=0			-- Bot Weapons Setting
fai_update_settings()

vai_mode={}; vai_smode={}		-- current mode / sub-mode
vai_timer={}					-- timer
vai_destx={}; vai_desty={}		-- destination x|y
vai_aimx={}; vai_aimy={}		-- aim at x|y
vai_px={}; vai_py={}			-- previous x|y
vai_target={}					-- target
vai_reaim={}; vai_rescan={}		-- re-aim / re-scan (freeline)
vai_itemscan={}					-- itemscan countdown
vai_buyingdone={}				-- buying done?
vai_radioanswer={}				-- radio answer?
vai_radioanswert={}				-- radio answer timer
for i=1,32 do
	vai_mode[i]=-1; vai_smode[i]=0; vai_timer[i]=0; vai_destx[i]=0; vai_desty[i]=0; vai_aimx[i]=0; vai_aimy[i]=0;
	vai_px[i]=0; vai_px[i]=0; vai_target[i]=0; vai_reaim[i]=0; vai_rescan[i]=0; vai_itemscan[i]=0; vai_buyingdone[i]=0;
	vai_radioanswer[i]=0; vai_radioanswert[i]=0;
end

-- "ai_onspawn" - AI On Spawn Function
-- This function is called by CS2D automatically after each spawn of a bot
-- Parameter: id = player ID of the bot
function ai_onspawn(id)
	-- reload settings
	fai_update_settings()
	-- reset variables
	vai_mode[id]=-1; vai_smode[id]=0
	vai_timer[id]=math.random(1,10)
	vai_destx[id]=0; vai_desty[id]=0
	vai_aimx[id]=player(id,"x")-50+math.random(0,100)
	vai_aimy[id]=player(id,"y")-50+math.random(0,100)
	vai_px[id]=player(id,"x")
	vai_py[id]=player(id,"y")
	vai_target[id]=0
	vai_reaim[id]=0; vai_rescan[id]=0
	vai_itemscan[id]=1000
	vai_buyingdone[id]=0
	vai_radioanswer[id]=0; vai_radioanswert[id]=0;
end

-- "ai_update_living" - AI Update Living Function
-- This function is called by CS2D automatically for each *LIVING* bot each frame
-- Parameter: id = player ID of the bot
function ai_update_living(id)
		
	-- Engage / Aim
	fai_engage(id)
	
	-- Radio Answer
	if vai_radioanswert[id]>0 then
		vai_radioanswert[id]=vai_radioanswert[id]-1
		if vai_radioanswert[id]<=0 then
			ai_radio(id,vai_radioanswer[id])
			vai_radioanswer[id]=0; vai_radioanswert[id]=0
		end
	end
	
	if player(id,"health")>0 and player(id,"team")>0 then
		
		-- Collect Items
		fai_collect(id)
		
		if player(id,"health")>0 and player(id,"team")>0 then
			
			ai_debug(id,"m:"..vai_mode[id]..", sm:"..vai_smode[id].." t:"..vai_target[id])
			
			if vai_mode[id]==0 then
				-- 0: IDLE ------------------------------------------------> decide what to do next
				vai_timer[id]=0; vai_smode[id]=0
				fai_decide(id)
				
			elseif vai_mode[id]==1 then
				-- 1: CAMP ------------------------------------------------> do nothing
				fai_wait(id,0)
				
			elseif vai_mode[id]==2 then
				-- 2: GOTO ------------------------------------------------> go to destination
				local result=ai_goto(id,vai_destx[id],vai_desty[id])
				if result==1 then
					vai_mode[id]=0
				elseif result==0 then
					vai_mode[id]=0
				else
					fai_walkaim(id)
				end
				
			elseif vai_mode[id]==3 then
				-- 3: ROAM ------------------------------------------------> randomly run round
				if ai_move(id,vai_smode[id])==0 then
					-- Bot failed to walk (way blocked) -> turn
					if (id%2)==0 then
						vai_smode[id]=vai_smode[id]+45
					else
						vai_smode[id]=vai_smode[id]-45
					end
					vai_timer[id]=math.random(150,250)
				end
				fai_walkaim(id)
				fai_wait(id,0)

			elseif vai_mode[id]==4 then
				-- 4: FIGHT -----------------------------------------------> fight
				if player(vai_target[id],"exists") then
					if player(vai_target[id],"health")>0 then
						-- Melee Combat?
						if itemtype(player(id,"weapontype"),"range")<50 then
							-- Yes, melee! Run to target
							if ai_goto(id,player(vai_target[id],"tilex"),player(vai_target[id],"tiley"))~=2 then
								vai_mode[id]=0
							end
						else
							-- No, regular combat!
							vai_timer[id]=vai_timer[id]-1
							if vai_timer[id]<=0 then
								vai_timer[id]=math.random(50,150)
								vai_smode[id]=math.random(0,360)
								-- Hunt?
								if math.random(1,2)==1 then
									if player(id,"health")>50 then
										if math.abs(player(id,"x")-player(vai_target[id],"x"))>230 and math.abs(player(id,"y")-player(vai_target[id],"y"))>180 then
											vai_mode[id]=5
											vai_smode[id]=vai_target[id]
										end
									end
								end
							end
							if ai_move(id,vai_smode[id])==0 then
								-- Bot failed to walk (way blocked) -> turn
								if (id%2)==0 then
									vai_smode[id]=vai_smode[id]+45
								else
									vai_smode[id]=vai_smode[id]-45
								end
								vai_timer[id]=math.random(50,150)
							end
						end
						return
					end
				end
				-- End Fight
				vai_mode[id]=0

			elseif vai_mode[id]==5 then
				-- 5: HUNT -----------------------------------------------> hunt
				if player(vai_smode[id],"exists") then
					if player(vai_smode[id],"health")>0 then
						if ai_goto(id,player(vai_smode[id],"tilex"),player(vai_smode[id],"tiley"))~=2 then
							vai_mode[id]=0
						end
						return
					end
				end
				-- End Hunt
				vai_mode[id]=0
				
			elseif vai_mode[id]==6 then
				-- 6: COLLECT --------------------------------------------> collect
				if ai_goto(id,vai_destx[id],vai_desty[id])~=2 then
					vai_mode[id]=0
					vai_itemscan[id]=140
				else
					fai_walkaim(id)
				end
				
			elseif vai_mode[id]==7 then
				-- 7: FOLLOW -----------------------------------------------> follow
				if player(vai_smode[id],"exists") then
					if player(vai_smode[id],"health")>0 then
						ai_goto(id,player(vai_smode[id],"tilex"),player(vai_smode[id],"tiley"))
						fai_walkaim(id)
						return
					end
				end
				-- End Follow
				vai_mode[id]=0
				
			
			elseif vai_mode[id]==50 then
				-- 50: RESCUE ---------------------------------------------> rescue hostages
				if vai_smode[id]==0 then
					-- Find and use hostages
					if ai_goto(id,vai_destx[id],vai_desty[id])~=2 then
						vai_mode[id]=0
					else
						fai_walkaim(id)
					end
					-- Find Hostages
					local h=hostage(0,"table")
					for i=1,#h do
						if hostage(h[i],"health")>0 and hostage(h[i],"follow")==0 then
							-- Close enough? Use!
							if math.abs(player(id,"x")-hostage(h[i],"x"))<=15 and math.abs(player(id,"y")-hostage(h[i],"y"))<=15 then
								ai_rotate(id,fai_angleto(player(id,"x"),player(id,"y"),hostage(h[i],"x"),hostage(h[i],"y")))
								ai_use(id)
								break
							end
						end
					end
					-- Get closest Hostage
					vai_destx[id],vai_desty[id]=closehostage(id)
					if vai_destx[id]==-100 then
						-- None found? Switch to rescue
						vai_smode[id]=1
						vai_destx[id],vai_desty[id]=randomentity(4) -- info_rescuepoint
						if vai_destx[id]==-100 then
							vai_destx[id],vai_desty[id]=randomentity(1) -- info_ct
						end
					end
				else
					-- Return and rescue hostages
					local result=ai_goto(id,vai_destx[id],vai_desty[id])
					if result==1 then
						vai_mode[id]=3
						vai_timer[id]=math.random(150,300)
						vai_smode[id]=math.random(0,360)
					elseif result==0 then
						vai_mode[id]=0
					else
						fai_walkaim(id)
					end
				end

			elseif vai_mode[id]==51 then
				-- 51: PLANT ----------------------------------------------> plant bomb
				if player(id,"bomb") then
					-- On bombspot?
					if tile(player(id,"tilex"),player(id,"tiley"),"entity")~=0 then
						if inentityzone(player(id,"tilex"),player(id,"tiley"),5) then
							-- Bomb selected?
							if player(id,"weapontype")~=55 then
								-- Select bomb!
								ai_selectweapon(id,55)
							else
								-- Plant
								if vai_timer[i]==0 then
									ai_radio(id,6) -- cover me!
									vai_timer[i]=1
								end
								ai_attack(id)
							end
							return
						end
					end
					-- Not on bombspot -> Goto bombspot!
					if ai_goto(id,vai_destx[id],vai_desty[id])~=2 then
						vai_destx[id],vai_desty[id]=randomentity(5) -- info_bombspot
					else
						fai_walkaim(id)
					end
				else
					-- Has no bomb anymore! no planting!
					vai_mode[id]=0
				end
				
			elseif vai_mode[id]==52 then
				-- 52: DEFUSE ---------------------------------------------> defuse bomb
				if vai_smode[id]==0 then
					-- Check Bombspot
					if ai_goto(id,vai_destx[id],vai_desty[id])~=2 then
						vai_destx[id],vai_desty[id]=randomentity(5,0) -- info_bombspot
					else
						fai_walkaim(id)
					end
					-- Close to spot? Check
					if math.abs(player(id,"tilex")-vai_destx[id])<7 and math.abs(player(id,"tiley")-vai_desty[id])<7 then
						local it=item(0,"table")
						for i=1,#it do
							if item(it[i],"type")==63 then
								if math.abs(player(id,"tilex")-item(it[i],"x"))<10 and math.abs(player(id,"tiley")-item(it[i],"y"))<10 then
									-- Bomb at spot!
									vai_destx[id]=item(it[i],"x")
									vai_desty[id]=item(it[i],"y")
									vai_smode[id]=1
									return
								end
							end
						end
						-- No bomb at spot!
						setentityaistate(vai_destx[id],vai_desty[id],1)
						print "SECTOR CLEAR!"
						ai_radio(id,5) -- sector clear!
						local bots=player(0,"table")
						for i=1,#bots do
							if player(bots[i],"bot")==1 then
								if vai_mode[bots[i]]==52 and vai_destx[bots[i]]==vai_destx[id] and vai_desty[bots[i]]==vai_desty[id] then
									vai_destx[bots[i]],vai_desty[bots[i]]=randomentity(5,0)
									vai_smode[bots[i]]=0
								end
							end
						end
						vai_destx[id],vai_desty[id]=randomentity(5,0) -- info_bombspot
						return
					end
				else
					-- Defuse Bomb
					local result=ai_goto(id,vai_destx[id],vai_desty[id])
					if result==1 then
						-- Defuse!
						if vai_timer[i]==0 then
							ai_radio(id,6) -- cover me!
							vai_timer[i]=1
						end
						ai_use(id)
					elseif result==0 then
						-- Failed to reach bomb
						vai_mode[id]=0
					end
				end
			
			elseif vai_mode[id]==-1 then
				-- -1: BUY ------------------------------------------------> buy equipment
				fai_buy(id)
			
			else
				-- INVALID MODE -------------------------------------------> invalid -> select new mode
				print("invalid AI mode: "..vai_mode[id])
				vai_mode[id]=0
			end
		
		end
	end
end

-- "ai_update_dead" - AI Update Dead Function
-- This function is called by CS2D automatically for each *DEAD* bot each second
-- Parameter: id = player ID of the bot
function ai_update_dead(id)
	-- Try to respawn (if not in normal gamemode)
	if vai_set_gm~=0 then
		ai_respawn(id)
	end
end

-- "ai_hear_radio" - AI Hear Radio
-- This function is called once for each radio message
-- Parameter: source = player ID of the player who sent the radio message
-- Parameter: radio = radio message ID
function ai_hear_radio(source,radio)
	-- print("AI HEARD RADIO FROM "..source.." RADIO ID: "..radio)
	-- Bomb planted!
	if radio==4 then
		-- Every CT will try to defuse!
		local bots=player(0,"table")
		for i=1,#bots do
			if player(bots[i],"bot")==1 and player(bots[i],"team")==2 then
				if vai_mode[bots[i]]~=52 then
					vai_destx[bots[i]],vai_desty[bots[i]]=randomentity(5,0)
					vai_mode[bots[i]]=52; vai_smode[bots[i]]=0; vai_timer[bots[i]]=0
				end
			end
		end
	-- Need Backup / Cover me / Follow Me
	elseif radio==1 or radio==6 or radio==13 then
		local mate=fai_randommate(source)
		if mate~=0 then
			if math.random(1,2)==1 then vai_radioanswer[mate]=0 else vai_radioanswer[mate]=28 end
			vai_radioanswert[mate]=math.random(35,100)
			vai_mode[mate]=7; vai_smode[mate]=source
		end
	-- Enemy spotted / Taking fire, need assistance
	elseif radio==9 or radio==11 then
		local mate=fai_randommate(source)
		if mate~=0 then
			if math.random(1,2)==1 then vai_radioanswer[mate]=0 else vai_radioanswer[mate]=28 end
			vai_radioanswert[mate]=math.random(35,100)
			vai_mode[mate]=2
			vai_destx[mate]=player(source,"tilex")
			vai_desty[mate]=player(source,"tiley")
		end
	-- Regroup Team (stop following)
	elseif radio==24 then
		local team=player(source,"team")
		if team>2 then team=2 end
		local mates=player(0,"team"..team.."living")
		local c=1
		for mate=1,#mates do
			if vai_mode[mate]==7 then
				if math.random(1,2)==1 then vai_radioanswer[mate]=0 else vai_radioanswer[mate]=28 end
				vai_radioanswert[mate]=math.random(50,55)*c
				c=c+1
				vai_mode[mate]=0
			end
		end
	-- Hold Position
	elseif radio==23 then
		local mate=fai_randommate(source)
		if mate~=0 then
			if math.random(1,2)==1 then vai_radioanswer[mate]=0 else vai_radioanswer[mate]=28 end
			vai_radioanswert[mate]=math.random(35,100)
			vai_mode[mate]=1; vai_timer[mate]=math.random(50*30,50*60)
		end
	-- Team Fall Back / Go Go Go / Stick Together / Storm the Front / You take the point
	elseif radio==10 or radio==15 or radio==30 or radio==31 or radio==32 then
		local team=player(source,"team")
		if team>2 then team=2 end
		local mates=player(0,"team"..team.."living")
		local c=1
		for mate=1,#mates do
			if vai_mode[mate]==1 or vai_mode[mate]==7 then
				if math.random(1,2)==1 then vai_radioanswer[mate]=0 else vai_radioanswer[mate]=28 end
				vai_radioanswert[mate]=math.random(50,55)*c
				c=c+1
				vai_mode[mate]=0
			end
		end
	-- Report in
	elseif radio==25 then
		local mate=fai_randommate(source)
		if mate~=0 then
			vai_radioanswer[mate]=26
			vai_radioanswert[mate]=math.random(35,100)
		end
	end
end

-- "ai_hear_chat" - AI Hear Chat
-- This function is called once for each chat message
-- Parameter: source = player ID of the player who sent the radio message
-- Parameter: msg = chat text message
-- Parameter: teamonly = team only chat message (1) or public chat message (0)
function ai_hear_chat(source,msg,teamonly)
	-- Ignore chat
end

map = __map
game = __game
player = __player
item = __item
menu = __menu