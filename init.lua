METALIBDIR = METALIBDIR
if METALIBDIR == nil then
	METALIBDIR = './sys/lua/libraries'
end

MetaLibrariesVersion = 83
MetaLibrariesDebug = true
MetaLibrariesConst = {}
MetaLibraries = {}

BOTSDIR = './bots'
GFXDIR = './gfx'
MAPSDIR = './maps'
SFXDIR = './sfx'
SYSDIR = './sys'
LUADIR = SYSDIR ..'/lua'
SERVERDIR = io.popen'cd':read'*l' or ''
--package.path = './?.lua;./sys/lua/?.lua;./sys/lua/?/init.lua;'.. SERVERDIR ..'/sys/lua/?.lua;'.. SERVERDIR ..'/sys/lua/?/init.lua'
--package.cpath = './?.dll;./sys/lua/?.dll;./?.so;./sys/lua/?.so;'.. SERVERDIR ..'/?.dll;'.. SERVERDIR ..'/sys/lua/?.dll;'.. SERVERDIR ..'/?.so;'.. SERVERDIR ..'/sys/lua/?.so'

local function pif(public, name, path)
	local private = {}
	
	public.RunConsoleCommand = parse
	
	print('©255220000Loading MetaLibraries.')
	print('©255220000Version: '.. MetaLibrariesVersion)
	
	public.enum_armor_type = import(METALIBDIR ..'/enum/armor_types.lua')
	public.enum_gamemode = import(METALIBDIR ..'/enum/gamemodes.lua')
	public.enum_hook = import(METALIBDIR ..'/enum/hooks.lua')
	public.enum_item = import(METALIBDIR ..'/enum/items.lua')
	public.enum_object = import(METALIBDIR ..'/enum/object.lua')
	public.enum_print_type = import(METALIBDIR ..'/enum/print_types.lua')
	public.enum_supply_mode = import(METALIBDIR ..'/enum/supply_modes.lua')
	public.enum_team = import(METALIBDIR ..'/enum/teams.lua')
	public.enum_text_align = import(METALIBDIR ..'/enum/text_align.lua')
	public.ext_string = import(METALIBDIR ..'/extensions/string.lua')
	public.string = public.ext_string
	public.ext_table = import(METALIBDIR ..'/extensions/table.lua')
	public.table = public.ext_table
	public.util = import(METALIBDIR ..'/util.lua')
	public.mod_hook = import(METALIBDIR ..'/modules/hook.lua')
	public.hook = public.mod_hook
	public.mod_concommand = import(METALIBDIR ..'/modules/concommand.lua')
	public.concommand = public.mod_concommand
	public.mod_chatcommand = import(METALIBDIR ..'/modules/chatcommand.lua')
	public.chatcommand = public.mod_chatcommand
	public.mod_file = import(METALIBDIR ..'/modules/file.lua')
	public.file = public.mod_file
	public.mod_ini = import(METALIBDIR ..'/modules/ini.lua')
	public.ini = public.mod_ini
	public.mod_server_settings = import(METALIBDIR ..'/modules/server_settings.lua')
	public.server_settings = public.mod_server_settings
	public.ext_convert = import(METALIBDIR ..'/extensions/convert.lua')
	public.convert = public.ext_convert
	public.ext_entity = import(METALIBDIR ..'/extensions/entity.lua')
	public.entity = public.ext_entity
	public.ext_game = import(METALIBDIR ..'/extensions/game.lua')
	public.game = public.ext_game
	public.ext_gamemode = import(METALIBDIR ..'/extensions/gamemode.lua')
	public.gamemode = ext_gamemode
	--[[public.ext_item = import(METALIBDIR ..'/extensions/item.lua')
	public.ext_item_networked = import(METALIBDIR ..'/extensions/item_networked.lua')--]]
	public.ext_map = import(METALIBDIR ..'/extensions/map.lua')
	public.map = public.ext_map
	public.ext_object = import(METALIBDIR ..'/extensions/object.lua')
	public.object = public.ext_object
	public.ext_player = import(METALIBDIR ..'/extensions/player.lua')
	public.player = public.ext_player
	--public.ext_menu = import(METALIBDIR ..'/extensions/menu.lua')
	public.ext_player_networked = import(METALIBDIR ..'/extensions/player_networked.lua')
	public.ext_player_auth = import(METALIBDIR ..'/extensions/player_auth.lua')
	public.ext_team = import(METALIBDIR ..'/extensions/team.lua')
	public.team = public.ext_team
	public.ext_tile = import(METALIBDIR ..'/extensions/tile.lua')
	public.tile = public.ext_tile
	public.ext_weapon = import(METALIBDIR ..'/extensions/weapon.lua')
	public.weapon = public.ext_weapon
	public.ext_usable = import(METALIBDIR ..'/extensions/usable.lua')
	public.usable = public.ext_usable
	--public.ext_timer = import(METALIBDIR ..'/modules/timer.lua')

	function MetaLibraries.GetHook(name)
		return MetaLibrariesConst.HookTable[name]
	end

	--[Time]--
	function MetaLibraries.OnMs100()
		if MetaLibraries.GetHook('ms100') ~= nil then
			for k, v in pairs(MetaLibraries.GetHook('ms100')) do
				v.func()
			end
		end
	end
	
	function MetaLibraries.OnSecond()
		if MetaLibraries.GetHook('second') ~= nil then
			for k, v in pairs(MetaLibraries.GetHook('second')) do
				v.func()
			end
		end
	end
	addhook('second', 'MetaLibraries.OnSecond')

	function MetaLibraries.OnMinute()
		if MetaLibraries.GetHook('minute') ~= nil then
			for k, v in pairs(MetaLibraries.GetHook('minute')) do
				v.func()
			end
		end
	end
	addhook('minute', 'MetaLibraries.OnMinute')

	function MetaLibraries.OnAlways()
		if MetaLibraries.GetHook('always') ~= nil then
			for k, v in pairs(MetaLibraries.GetHook('always')) do
				v.func()
			end
		end
	end
	addhook('always', 'MetaLibraries.OnAlways')

	--[Basic]--
	function MetaLibraries.OnStartRound(mode)
		if MetaLibrariesDebug then print('OnStartRound: '.. mode) end
		if MetaLibraries.GetHook('startround') ~= nil then
			for k, v in pairs(MetaLibraries.GetHook('startround')) do
				v.func(mode)
			end
		end
	end
	addhook('startround', 'MetaLibraries.OnStartRound')

	function MetaLibraries.OnEndRound(mode)
		if MetaLibrariesDebug then print('OnEndRound: '.. mode) end
		if MetaLibraries.GetHook('endround') ~= nil then
			for k, v in pairs(MetaLibraries.GetHook('endround')) do
				v.func(mode)
			end
		end
	end
	addhook('endround', 'MetaLibraries.OnEndRound')

	function MetaLibraries.OnMapChange(newmap)
		if MetaLibrariesDebug then print('OnMapChange: '.. newmap) end
		if MetaLibraries.GetHook('mapchange') ~= nil then
			for k, v in pairs(MetaLibraries.GetHook('mapchange')) do
				v.func(newmap)
			end
		end
	end
	addhook('mapchange', 'MetaLibraries.OnMapChange')

	function MetaLibraries.OnParse(text)
		if MetaLibrariesDebug then print('OnParse: '.. text) end
		if MetaLibraries.GetHook('parse') ~= nil then
			local cmd = public.ext_string.split(' ', text)[1]
			local args = public.ext_string.split(' ', text:sub(cmd:len() + 2))
			
			for k, v in pairs(MetaLibraries.GetHook('parse')) do
				local r = v.func(cmd, args)
				if r ~= nil then
					return r
				end
			end
		end
	end
	--addhook('parse', 'MetaLibraries.OnParse')

	function MetaLibraries.OnTrigger(trigger, source)
		if source then source = 1 else source = 0 end
		if MetaLibrariesDebug then print('OnTrigger: '.. trigger ..' '.. source) end
		if MetaLibraries.GetHook('trigger') ~= nil then
			for k, v in pairs(MetaLibraries.GetHook('trigger')) do
				local r = v.func(trigger, source)
				if r ~= nil then
					return r
				end
			end
		end
	end
	addhook('trigger', 'MetaLibraries.OnTrigger')

	function MetaLibraries.OnTriggerEntity(x, y)
		if MetaLibrariesDebug then print('OnTriggerEntity: '.. x ..' '.. y) end
		if MetaLibraries.GetHook('triggerentity') ~= nil then
			for k, v in pairs(MetaLibraries.GetHook('triggerentity')) do
				local r = v.func(public.ext_entity.GetByPos(x, y))
				if r ~= nil then
					return r
				end
			end
		end
	end
	addhook('triggerentity', 'MetaLibraries.OnTriggerEntity')
	
	function MetaLibraries.OnBreaks(x, y)
		if MetaLibrariesDebug then print('OnBreaks: '.. x ..' '.. y) end
		if MetaLibraries.GetHook('break') ~= nil then
			for k, v in pairs(MetaLibraries.GetHook('break')) do
				v.func(public.ext_entity.GetByPos(x, y))
			end
		end
	end
	addhook('break', 'MetaLibraries.OnBreaks')

	function MetaLibraries.OnProjecTile(id, wpn, x, y)
		if MetaLibrariesDebug then print('OnProjecTile: '.. id ..' '.. wpn ..' '.. x ..' '.. y) end
		if MetaLibraries.GetHook('projectile') ~= nil then
			for k, v in pairs(MetaLibraries.GetHook('projectile')) do
				v.func(public.ext_player.GetByID(id), public.ext_weapon.GetByType(wpn), x, y)
			end
		end
	end
	addhook('projectile', 'MetaLibraries.OnProjecTile')

	function MetaLibraries.OnLog(text)
		if MetaLibraries.GetHook('log') ~= nil then
			for k, v in pairs(MetaLibraries.GetHook('log')) do
				local r = v.func(text)
				if r ~= nil then
					return r
				end
			end
		end
	end
	addhook('log', 'MetaLibraries.OnLog')

	function MetaLibraries.OnRcon(message, id, ip, port)
		if MetaLibrariesDebug then print('OnRcon: '.. message ..' '.. id ..' '.. ip ..' '.. port) end
		if MetaLibraries.GetHook('rcon') ~= nil then
			local cmd = public.ext_string.split(' ', message)[1]
			local args = public.ext_string.split(' ', message:sub(cmd:len() + 2))
				
			for k, v in pairs(MetaLibraries.GetHook('rcon')) do
				local r = v.func(public.ext_player.Rcon(id, ip, port), cmd, args)
				if r ~= nil then
					return r
				end
			end
		end
	end
	addhook('rcon', 'MetaLibraries.OnRcon')

	function MetaLibraries.OnClientData(id, mode, x, y)
		if MetaLibrariesDebug then print('OnClientData: '.. id ..' '.. mode ..' '.. x ..' '.. y) end
		if MetaLibraries.GetHook('clientdata') ~= nil then
			for k, v in pairs(MetaLibraries.GetHook('clientdata')) do
				local r = v.func(public.ext_player.GetByID(id), mode, x, y)
				if r ~= nil then
					return r
				end
			end
		end
	end
	addhook('clientdata', 'MetaLibraries.OnClientData')

	--[Player]--
	function MetaLibraries.OnJoin(id)
		if MetaLibrariesDebug then print('OnJoin: '.. id) end
		public.ext_player.GetByID(id):PrintMessage(public.enum_print_type.HUD_PRINTCENTER, '©000128128The server uses the module MetaLibraries developed by MetaInnovative.')
		
		if MetaLibraries.GetHook('join') ~= nil then
			for k, v in pairs(MetaLibraries.GetHook('join')) do
				v.func(public.ext_player.GetByID(id))
			end
		end
	end
	addhook('join', 'MetaLibraries.OnJoin')

	function MetaLibraries.OnLeave(id, reason)
		if MetaLibrariesDebug then print('OnLeave: '.. id ..' '.. reason) end
		if MetaLibraries.GetHook('leave') ~= nil then
			for k, v in pairs(MetaLibraries.GetHook('leave')) do
				v.func(public.ext_player.GetByID(id), reason)
			end
		end
	end
	addhook('leave', 'MetaLibraries.OnLeave')

	function MetaLibraries.OnChangeTeam(id, team, look)
		if MetaLibrariesDebug then print('OnChangeTeam: '.. id ..' '.. team ..' '.. look) end
		if MetaLibraries.GetHook('team') ~= nil then
			for k, v in pairs(MetaLibraries.GetHook('team')) do
				local r = v.func(public.ext_player.GetByID(id), team, look)
				if r ~= nil then
					return r
				end
			end
		end
	end
	addhook('team', 'MetaLibraries.OnChangeTeam')

	function MetaLibraries.OnSpawn(id)
		if MetaLibrariesDebug then print('OnSpawn: '.. id) end
		if MetaLibraries.GetHook('spawn') ~= nil then
			for k, v in pairs(MetaLibraries.GetHook('spawn')) do
				local r = v.func(public.ext_player.GetByID(id))
				if r ~= nil then
					return r
				end
			end
		end
	end
	addhook('spawn', 'MetaLibraries.OnSpawn')

	function MetaLibraries.OnNameChange(id, oldname, newname)
		if MetaLibrariesDebug then print('OnNameChange: '.. id ..' '.. oldname ..' '.. newname) end
		if MetaLibraries.GetHook('name') ~= nil then
			for k, v in pairs(MetaLibraries.GetHook('name')) do
				local r = v.func(public.ext_player.GetByID(id), oldname, newname)
				if r ~= nil then
					return r
				end
			end
		end
	end
	addhook('name', 'MetaLibraries.OnNameChange')

	function MetaLibraries.OnServerAction(id, action)
		if MetaLibrariesDebug then print('OnServerAction: '.. id ..' '.. action) end
		if MetaLibraries.GetHook('serveraction') ~= nil then
			if action == 1 then
				if MetaLibraries.GetHook('serveraction')['f2'] ~= nil then
					MetaLibraries.GetHook('serveraction')['f2'](public.ext_player.GetByID(id))
				end
			elseif action == 2 then
				if MetaLibraries.GetHook('serveraction')['f3'] ~= nil then
					MetaLibraries.GetHook('serveraction')['f3'](public.ext_player.GetByID(id))
				end
			elseif action == 3 then
				if MetaLibraries.GetHook('serveraction')['f4'] ~= nil then
					MetaLibraries.GetHook('serveraction')['f4'](public.ext_player.GetByID(id))
				end
			end
		end
	end
	addhook('serveraction', 'MetaLibraries.OnServerAction')

	function MetaLibraries.OnBuy(id, wpn)
		if MetaLibrariesDebug then print('OnBuy: '.. id ..' '.. wpn) end
		if MetaLibraries.GetHook('buy') ~= nil then
			for k, v in pairs(MetaLibraries.GetHook('buy')) do
				local r = v.func(public.ext_player.GetByID(id), public.ext_weapon.GetByType(wpn))
				if r ~= nil then
					return r
				end
			end
		end
	end
	addhook('buy', 'MetaLibraries.OnBuy')

	function MetaLibraries.OnWalkover(id, iid, type, ain, a, mode)
		print('OnWalkover: '.. id ..' '.. iid ..' '.. type ..' '.. ain ..' '.. a ..' '.. mode)
		local i = public.ext_item.GetByID(iid)
		print('OnWalkover: '.. id ..' '.. iid ..' '.. i:Type() ..' '.. i:Ammoin() ..' '.. i:Ammo() ..' '.. i:Mode())
		if MetaLibraries.GetHook('walkover') ~= nil then
			for k, v in pairs(MetaLibraries.GetHook('walkover')) do
				local r = v.func(public.ext_player.GetByID(id), public.ext_item.GetByID(iid), type, ain, a, mode)
				if r ~= nil then
					return r
				end
			end
		end
	end
	addhook('walkover', 'MetaLibraries.OnWalkover')

	function MetaLibraries.OnCollect(id, iid, type, ain, a, mode)
		print('OnCollect: '.. id ..' '.. iid ..' '.. type ..' '.. ain ..' '.. a ..' '.. mode)
		local i = public.ext_item.GetByID(iid)
		print('OnWalkover: '.. id ..' '.. iid ..' '.. i:Type() ..' '.. i:Ammoin() ..' '.. i:Ammo() ..' '.. i:Mode())
		if MetaLibraries.GetHook('collect') ~= nil then
			for k, v in pairs(MetaLibraries.GetHook('collect')) do
				v.func(public.ext_player.GetByID(id), public.ext_item.GetByID(iid), type, ain, a, mode)
			end
		end
	end
	addhook('collect', 'MetaLibraries.OnCollect')

	function MetaLibraries.OnDrop(id, iid, type, ain, a, mode, x, y)
		print('OnDrop: '.. id ..' '.. iid ..' '.. type ..' '.. ain ..' '.. a ..' '.. mode ..' '.. x ..' '.. y)
		local i = public.ext_item.GetByID(iid)
		print('OnWalkover: '.. id ..' '.. iid ..' '.. i:Type() ..' '.. i:Ammoin() ..' '.. i:Ammo() ..' '.. i:Mode())
		if MetaLibraries.GetHook('drop') ~= nil then
			for k, v in pairs(MetaLibraries.GetHook('drop')) do
				local r = v.func(public.ext_player.GetByID(id), public.ext_item.GetByID(iid), type, ain, a, mode, x, y)
				if r ~= nil then
					return r
				end
			end
		end
	end
	addhook('drop', 'MetaLibraries.OnDrop')

	function MetaLibraries.OnChangeWeapon(id, type, mode)
		if MetaLibrariesDebug then print('OnChangeWeapon: '.. id ..' '.. type ..' '.. mode) end
		if MetaLibraries.GetHook('select') ~= nil then
			for k, v in pairs(MetaLibraries.GetHook('select')) do
				v.func(public.ext_player.GetByID(id), public.ext_weapon.GetByType(type), mode)
			end
		end
	end
	addhook('select', 'MetaLibraries.OnChangeWeapon')

	function MetaLibraries.OnReload(id)
		if MetaLibrariesDebug then print('OnReload: '.. id) end
		if MetaLibraries.GetHook('reload') ~= nil then
			for k, v in pairs(MetaLibraries.GetHook('reload')) do
				v.func(public.ext_player.GetByID(id))
			end
		end
	end
	addhook('reload', 'MetaLibraries.OnReload')

	function MetaLibraries.OnFire(id)
		if MetaLibrariesDebug then print('OnFire: '.. id) end
		if MetaLibraries.GetHook('attack') ~= nil then
			for k, v in pairs(MetaLibraries.GetHook('attack')) do
				v.func(public.ext_player.GetByID(id))
			end
		end
	end
	addhook('attack', 'MetaLibraries.OnFire')

	function MetaLibraries.OnAdvancedFire(id, mode)
		if MetaLibrariesDebug then print('OnAdvancedFire: '.. id ..' '.. mode) end
		if MetaLibraries.GetHook('attack2') ~= nil then
			for k, v in pairs(MetaLibraries.GetHook('attack2')) do
				v.func(public.ext_player.GetByID(id), mode)
			end
		end
	end
	addhook('attack2', 'MetaLibraries.OnAdvancedFire')

	function MetaLibraries.OnMove(id, x, y, walk)
		if MetaLibrariesDebug then print('OnMove: '.. id ..' '.. x ..' '.. y ..' '.. walk) end
		if MetaLibraries.GetHook('move') ~= nil then
			for k, v in pairs(MetaLibraries.GetHook('move')) do
				v.func(public.ext_player.GetByID(id), x, y, walk)
			end
		end
	end
	addhook('move', 'MetaLibraries.OnMove')

	function MetaLibraries.OnMoveTile(id, x, y)
		if MetaLibrariesDebug then print('OnMoveTile: '.. id ..' '.. x ..' '.. y) end
		if MetaLibraries.GetHook('movetile') ~= nil then
			for k, v in pairs(MetaLibraries.GetHook('movetile')) do
				v.func(public.ext_player.GetByID(id), x, y)
			end
		end
	end
	addhook('movetile', 'MetaLibraries.OnMoveTile')

	function MetaLibraries.OnHit(id, source, wpn, hpdmg, apdmg)
		if MetaLibrariesDebug then print('OnHit: '.. id ..' '.. source ..' '.. wpn ..' '.. hpdmg ..' '.. apdmg) end
		if MetaLibraries.GetHook('hit') ~= nil then
			for k, v in pairs(MetaLibraries.GetHook('hit')) do
				local r = v.func(public.ext_player.GetByID(id), public.ext_player.GetByID(source), public.ext_weapon.GetByType(wpn), hpdmg, apdmg)
				if r ~= nil then
					return r
				end
			end
		end
	end
	addhook('hit', 'MetaLibraries.OnHit')

	function MetaLibraries.OnKill(killer, victim, wpn, x, y)
		if MetaLibrariesDebug then print('OnKill: '.. killer ..' '.. victim ..' '.. wpn ..' '.. x ..' '.. y) end
		if MetaLibraries.GetHook('kill') ~= nil then
			for k, v in pairs(MetaLibraries.GetHook('kill')) do
				v.func(public.ext_player.GetByID(killer), public.ext_player.GetByID(victim), public.ext_weapon.GetByType(wpn), x, y)
			end
		end
	end
	addhook('kill', 'MetaLibraries.OnKill')

	function MetaLibraries.OnDie(victim, killer, wpn, x, y)
		if MetaLibrariesDebug then print('OnDie: '.. victim ..' '.. killer ..' '.. wpn ..' '.. x ..' '.. y) end
		if MetaLibraries.GetHook('die') ~= nil then
			for k, v in pairs(MetaLibraries.GetHook('die')) do
				local r = v.func(public.ext_player.GetByID(victim), public.ext_player.GetByID(killer), public.ext_weapon.GetByType(wpn), x, y)
				if r ~= nil then
					return r
				end
			end
		end
	end
	addhook('die', 'MetaLibraries.OnDie')

	function MetaLibraries.OnUse(id, event, data, x, y)
		if MetaLibrariesDebug then print('OnUse: '.. id ..' '.. event ..' '.. data ..' '.. x ..' '.. y) end
		if MetaLibraries.GetHook('use') ~= nil then
			for k, v in pairs(MetaLibraries.GetHook('use')) do
				v.func(public.ext_player.GetByID(id), event, data, x, y)
			end
		end
	end
	addhook('use', 'MetaLibraries.OnUse')

	function MetaLibraries.OnUseButton(id, x, y)
		if MetaLibrariesDebug then print('OnUseButton: '.. id ..' '.. x ..' '.. y) end
		if MetaLibraries.GetHook('usebutton') ~= nil then
			for k, v in pairs(MetaLibraries.GetHook('usebutton')) do
				v.func(public.ext_player.GetByID(id), public.ext_entity.GetByPos(x, y))
			end
		end
	end
	addhook('usebutton', 'MetaLibraries.OnUseButton')

	function MetaLibraries.OnSay(id, message)
		if MetaLibrariesDebug then print('OnSay: '.. id ..' '.. message) end
		local ply = public.ext_player.GetByID(id)
		if public.mod_chatcommand.Run(ply, message, false) then return HOOK_NOSAY end
		if MetaLibraries.GetHook('say') ~= nil then
			for k, v in pairs(MetaLibraries.GetHook('say')) do
				local r = v.func(ply, message)
				if r ~= nil then
					return r
				end
			end
		end
	end
	addhook('say', 'MetaLibraries.OnSay')

	function MetaLibraries.OnSayTeam(id, message)
		if MetaLibrariesDebug then print('OnSayTeam: '.. id ..' '.. message) end
		local ply = public.ext_player.GetByID(id)
		if public.mod_chatcommand.Run(ply, message, true) then return HOOK_NOSAYTEAM end
		if MetaLibraries.GetHook('sayteam') ~= nil then
			for k, v in pairs(MetaLibraries.GetHook('sayteam')) do
				local r = v.func(ply, message)
				if r ~= nil then
					return r
				end
			end
		end
	end
	addhook('sayteam', 'MetaLibraries.OnSayTeam')

	function MetaLibraries.OnRadio(id, message)
		if MetaLibrariesDebug then print('OnRadio: '.. id ..' '.. message) end
		if MetaLibraries.GetHook('radio') ~= nil then
			for k, v in pairs(MetaLibraries.GetHook('radio')) do
				local r = v.func(public.ext_player.GetByID(id), message)
				if r ~= nil then
					return r
				end
			end
		end
	end
	addhook('radio', 'MetaLibraries.OnRadio')

	function MetaLibraries.OnSpray(id)
		if MetaLibrariesDebug then print('OnSpray: '.. id) end
		if MetaLibraries.GetHook('spray') ~= nil then
			for k, v in pairs(MetaLibraries.GetHook('spray')) do
				v.func(public.ext_player.GetByID(id))
			end
		end
	end
	addhook('spray', 'MetaLibraries.OnSpray')

	function MetaLibraries.OnVote(id, mode, param)
		if MetaLibrariesDebug then print('OnVote: '.. id ..' '.. mode ..' '.. param) end
		if MetaLibraries.GetHook('vote') ~= nil then
			for k, v in pairs(MetaLibraries.GetHook('vote')) do
				v.func(public.ext_player.GetByID(id), mode, param)
			end
		end
	end
	addhook('vote', 'MetaLibraries.OnVote')

	function MetaLibraries.OnBuildAttempt(id, type, x, y)
		if MetaLibrariesDebug then print('OnBuildAttempt: '.. id ..' '.. type ..' '.. x ..' '.. y) end
		if MetaLibraries.GetHook('buildattempt') ~= nil then
			for k, v in pairs(MetaLibraries.GetHook('buildattempt')) do
				local r = v.func(public.ext_player.GetByID(id), type, x, y)
				if r ~= nil then
					return r
				end
			end
		end
	end
	addhook('buildattempt', 'MetaLibraries.OnBuildAttempt')

	function MetaLibraries.OnBuild(id, type, x, y, mode, objectid)
		if MetaLibrariesDebug then print('OnBuild: '.. id ..' '.. type ..' '.. x ..' '.. y ..' '.. mode ..' '.. objectid) end
		if MetaLibraries.GetHook('build') ~= nil then
			for k, v in pairs(MetaLibraries.GetHook('build')) do
				local r = v.func(public.ext_player.GetByID(id), type, x, y, mode, public.ext_object.GetByID(objectid))
				if r ~= nil then
					return r
				end
			end
		end
	end
	addhook('build', 'MetaLibraries.OnBuild')

	function MetaLibraries.OnFlagTake(id, team, x, y)
		if MetaLibrariesDebug then print('OnFlagTake: '.. id ..' '.. team ..' '.. x ..' '.. y) end
		if MetaLibraries.GetHook('flagtake') ~= nil then
			for k, v in pairs(MetaLibraries.GetHook('flagtake')) do
				local r = v.func(public.ext_player.GetByID(id), team, x, y)
				if r ~= nil then
					return r
				end
			end
		end
	end
	addhook('flagtake', 'MetaLibraries.OnFlagTake')

	function MetaLibraries.OnFlagCapture(id, team, x, y)
		if MetaLibrariesDebug then print('OnFlagCapture: '.. id ..' '.. team ..' '.. x ..' '.. y) end
		if MetaLibraries.GetHook('flagcapture') ~= nil then
			for k, v in pairs(MetaLibraries.GetHook('flagcapture')) do
				local r = v.func(public.ext_player.GetByID(id), team, x, y)
				if r ~= nil then
					return r
				end
			end
		end
	end
	addhook('flagcapture', 'MetaLibraries.OnFlagCapture')

	function MetaLibraries.OnDominate(id, team, x, y)
		if MetaLibrariesDebug then print('OnDominate: '.. id ..' '.. team ..' '.. x ..' '.. y) end
		if MetaLibraries.GetHook('dominate') ~= nil then
			for k, v in pairs(MetaLibraries.GetHook('dominate')) do
				local r = v.func(public.ext_player.GetByID(id), team, x, y)
				if r ~= nil then
					return r
				end
			end
		end
	end
	addhook('dominate', 'MetaLibraries.OnDominate')

	function MetaLibraries.OnBombPlant(id, x, y)
		if MetaLibrariesDebug then print('OnBombPlant: '.. id ..' '.. x ..' '.. y) end
		if MetaLibraries.GetHook('bombplant') ~= nil then
			for k, v in pairs(MetaLibraries.GetHook('bombplant')) do
				local r = v.func(public.ext_player.GetByID(id), x, y)
				if r ~= nil then
					return r
				end
			end
		end
	end
	addhook('bombplant', 'MetaLibraries.OnBombPlant')

	function MetaLibraries.OnBombDefuse(id)
		if MetaLibrariesDebug then print('OnBombDefuse: '.. id) end
		if MetaLibraries.GetHook('bombdefuse') ~= nil then
			for k, v in pairs(MetaLibraries.GetHook('bombdefuse')) do
				local r = v.func(public.ext_player.GetByID(id))
				if r ~= nil then
					return r
				end
			end
		end
	end
	addhook('bombdefuse', 'MetaLibraries.OnBombDefuse')

	function MetaLibraries.OnBombExplode(id, x, y)
		if MetaLibrariesDebug then print('OnBombExplode: '.. id ..' '.. x ..' '.. y) end
		if MetaLibraries.GetHook('bombexplode') ~= nil then
			for k, v in pairs(MetaLibraries.GetHook('bombexplode')) do
				local r = v.func(public.ext_player.GetByID(id), x, y)
				if r ~= nil then
					return r
				end
			end
		end
	end
	addhook('bombexplode', 'MetaLibraries.OnBombExplode')

	function MetaLibraries.OnHostageRescue(id, x, y)
		if MetaLibrariesDebug then print('OnHostageRescue: '.. id ..' '.. x ..' '.. y) end
		if MetaLibraries.GetHook('hostagerescue') ~= nil then
			for k, v in pairs(MetaLibraries.GetHook('hostagerescue')) do
				v.func(public.ext_player.GetByID(id), x, y)
			end
		end
	end
	addhook('hostagerescue', 'MetaLibraries.OnHostageRescue')

	function MetaLibraries.OnVipEscape(id, x, y)
		if MetaLibrariesDebug then print('OnVipEscape: '.. id ..' '.. x ..' '.. y) end
		if MetaLibraries.GetHook('vipescape') ~= nil then
			for k, v in pairs(MetaLibraries.GetHook('vipescape')) do
				v.func(public.ext_player.GetByID(id), x, y)
			end
		end
	end
	addhook('vipescape', 'MetaLibraries.OnVipEscape')

	function MetaLibraries.OnMenu(id, title, button)
		if MetaLibrariesDebug then print('OnMenu: '.. id ..' '.. title ..' '.. button) end
		if MetaLibraries.GetHook('menu') ~= nil then
			for k, v in pairs(MetaLibraries.GetHook('menu')) do
				v.func(public.ext_player.GetByID(id), title, button)
			end
		end
	end
	addhook('menu', 'MetaLibraries.OnMenu')

	if (public.ext_game.Version() == 'b 0.1.2.0') then
		function MetaLibraries.OnFlashlight(id, state)
			if MetaLibrariesDebug then print('OnFlashlight: '.. id ..' '.. state) end
			if MetaLibraries.GetHook('flashlight') ~= nil then
				for k, v in pairs(MetaLibraries.GetHook('flashlight')) do
					v.func(public.ext_player.GetByID(id), state)
				end
			end
		end
		addhook('flashlight', 'MetaLibraries.OnFlashlight')
	end
	
	--[Object]--
	function MetaLibraries.OnObjectDamage(id, damage, ply)
		if MetaLibrariesDebug then print('OnObjectDamage: '.. id ..' '.. damage ..' '.. ply) end
		if MetaLibraries.GetHook('objectdamage') ~= nil then
			for k, v in pairs(MetaLibraries.GetHook('objectdamage')) do
				local r = v.func(public.ext_object.GetByID(id), damage, public.ext_player.GetByID(ply))
				if r ~= nil then
					return r
				end
			end
		end
	end
	addhook('objectdamage', 'MetaLibraries.OnObjectDamage')

	function MetaLibraries.OnObjectKill(id, ply)
		if MetaLibrariesDebug then print('OnObjectKill: '.. id ..' '.. ply) end
		if MetaLibraries.GetHook('objectkill') ~= nil then
			for k, v in pairs(MetaLibraries.GetHook('objectkill')) do
				v.func(public.ext_object.GetByID(id), public.ext_player.GetByID(ply))
			end
		end
	end
	addhook('objectkill', 'MetaLibraries.OnObjectKill')

	function MetaLibraries.OnObjectUpgrade(id, ply, progress, total)
		if MetaLibrariesDebug then print('OnObjectUpgrade: '.. id ..' '.. ply ..' '.. progress ..' '.. total) end
		if MetaLibraries.GetHook('objectupgrade') ~= nil then
			for k, v in pairs(MetaLibraries.GetHook('objectupgrade')) do
				local r = v.func(public.ext_object.GetByID(id), public.ext_player.GetByID(ply), progress, total)
				if r ~= nil then
					return r
				end
			end
		end
	end
	addhook('objectupgrade', 'MetaLibraries.OnObjectUpgrade')
	
	--[[local i = 0
	for k, v in pairs(MetaLibraries) do
		if tostring(k) ~= 'GetHook' then
			i = i + 1
		end
	end
	print(string.format('©115110255Hook: %d', i))--]]

	--[[__LINE__ = (function()
		local currentline
		local i = 1
		while (i ~= 0 and debug.getinfo(i) ~= nil) do
			currentline = debug.getinfo(i).currentline
			print(currentline)
			if debug.getinfo(i).short_src == 'sys/lua/'.. public.mod_server_settings.GetConVarString('mp_luaserver', 'server.lua') then
				i = 0
			else
				i = i + 1
			end
		end
		return currentline
	end)()--]]
	__FILE__ = (function()
		local short_src
		local i = 1
		while (i ~= 0 and debug.getinfo(i) ~= nil) do
			short_src = debug.getinfo(i).short_src
			if short_src == 'sys/lua/'.. public.mod_server_settings.GetConVarString('mp_luaserver', 'server.lua') then
				i = 0
			else
				i = i + 1
			end
		end
		return './'.. short_src
	end)()
	__DIR__ = string.gsub(__FILE__, '^(.+)/[^/]+$', '%1')
	
	function public.dofile(filename)
		if public.mod_file.Exists(filename) then
			local __FILE__ = string.gsub(filename, '\\', '/');
			if string.sub(__FILE__, 2, 2) ~= ':' and string.sub(__FILE__, 0, 1) ~= '/' and string.sub(__FILE__, 0, 2) ~= './' then
				__FILE__ = './'.. __FILE__
			end
			local __DIR__ = string.gsub(__FILE__, '^(.+)/[^/]+$', '%1')
			if string.len(__DIR__) >= 6 and string.sub(__DIR__, 0, 6) == './bots' then
				dofile(filename)
			else
				--assert(loadstring('local __FILE__ = "'.. __FILE__ ..'";local __DIR__ = "'.. __DIR__ ..'";' .. public.mod_file.Read(filename)))()
				assert(loadstring('local __FILE__ = debug.getinfo(1).short_src;local __DIR__ = string.gsub(__FILE__, \'^(.+)/[^/]+$\', \'%1\');' .. public.mod_file.Read(filename)))()
			end
		else
			print('©255000000LUA ERROR: cannot open '.. filename ..': No such file or directory')
		end
	end

	--[[private.require = require;
	function require(filename)
		for _, v in ipairs(public.ext_string.split(';', package.path)) do
			local filename = v:gsub('?', filename);
			if public.mod_file.Exists(filename) then
				public.dofile(filename)
				return
			end
		end
		for _, v in ipairs(public.ext_string.split(';', package.cpath)) do
			local filename = v:gsub('?', filename);
			if public.mod_file.Exists(filename) then
				local module
				if string.find(filename, '.so') ~= nil then
					module = 'luaopen_linux'
				else
					module = 'luaopen_winmm'
				end
				package.loadlib(filename, module)
				return
			end
		end
		print('LUA ERROR: cannot open '.. filename ..': No such file or directory')
	end--]]
	
	print('©255220000MetaLibraries loaded!')
end

return pif