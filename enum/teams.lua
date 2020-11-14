local function pif(public, name, path)
	local private = {}

	public.TEAM_SPECTATOR			=	0
	public.TEAM_TERRORIST			= 	1
	public.TEAM_COUNTER_TERRORIST	=	2

	public.TEAM_SPEC	=	public.TEAM_SPECTATOR
	public.TEAM_T		=	public.TEAM_TERRORIST
	public.TEAM_CT		=	public.TEAM_COUNTER_TERRORIST
end

return pif