
-- Collect Items
function fai_collect(id)
	local ply = player.GetByID(id)
	
	-- Scan Timer
	vai_itemscan[id]=vai_itemscan[id]+1
	if vai_itemscan[id]>150 then
		vai_itemscan[id]=math.random(0,50)
		
		-- Not collecting yet AND not a zombie?
		if vai_mode[id]~=6 and not(ply:Team()==1 and vai_set_gm==4) then
			-- Find and scan close items
			local items=closeitems(id,5)
			for i=1,#items do
				local tile = item.GetByID(items[i]):Tile()
				
				-- Not on same tile?
				if tile.x~=ply:Tile().x or tile.y~=ply:Tile().y then
					local itype=item.GetByID(items[i]):Type()
					local slot=itemtype(itype,"slot")
					if slot==1 then
						-- Primary
						if not fai_playerslotitems(id,1) and ply:Team()~=3 then
							vai_mode[id]=6; vai_smode[id]=itype; vai_destx[id]=tile.x; vai_desty[id]=tile.y; break
						end
					elseif slot==2 then
						-- Secondary
						if not fai_playerslotitems(id,2) and ply:Team()~=3 then
							vai_mode[id]=6; vai_smode[id]=itype; vai_destx[id]=tile.x; vai_desty[id]=tile.y; break
						end
					elseif slot==3 then
						-- Melee
						local items2=playerweapons(id)
						if not fai_contains(items2,itype) and ply:Team()~=3 then
							vai_mode[id]=6; vai_smode[id]=itype; vai_destx[id]=tile.x; vai_desty[id]=tile.y; break
						end
					elseif slot==4 then
						-- Grenades
						local items2=playerweapons(id)
						if not fai_contains(items2,itype) and ply:Team()~=3 then
							vai_mode[id]=6; vai_smode[id]=itype; vai_destx[id]=tile.x; vai_desty[id]=tile.y; break
						end
					elseif slot==5 then
						-- Special
						if itype==55 then
							-- Bomb
							if ply:Team()==1 then
								vai_mode[id]=6; vai_smode[id]=itype; vai_destx[id]=tile.x; vai_desty[id]=tile.y; break
							end
						end
					elseif slot==0 then
						-- No Slot Items
						if itype==70 or itype==71 then
							-- Flags
							vai_mode[id]=6; vai_smode[id]=itype; vai_destx[id]=tile.x; vai_desty[id]=tile.y; break
						elseif itype>=66 and itype<=68 and ply:Money()<16000 then
							-- Money
							vai_mode[id]=6; vai_smode[id]=itype; vai_destx[id]=tile.x; vai_desty[id]=tile.y; break
						elseif itype>=64 and itype<=65 and ply:Health()<ply:MaxHealth() then
							-- Health
							vai_mode[id]=6; vai_smode[id]=itype; vai_destx[id]=tile.x; vai_desty[id]=tile.y; break
						end
					end
				end
			end
		end
	end
end