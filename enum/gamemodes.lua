local function pif(public, name, path)
	local private = {}

	public.GAMEMODE_STANDARD			=	0
	public.GAMEMODE_DEATHMATCH			= 	1
	public.GAMEMODE_TEAM_DEATHMATCH		=	2
	public.GAMEMODE_CONSTRUCTION		=	3
	public.GAMEMODE_ZOMBIE				=	4
end

return pif