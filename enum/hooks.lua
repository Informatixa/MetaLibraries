local function pif(public, name, path)
	local private = {}

	public.HOOK_TEAM				=	0
	public.HOOK_NOTEAM				=	1

	public.HOOK_SPAWN				=	""	-- spawn with regular items
	public.HOOK_MELEEONLY			=	"x"	-- spawn with melee weapon only
	public.HOOK_MELEE				=	MELEEONLY

	public.HOOK_NAME				=	0
	public.HOOK_NONAME				=	1

	public.HOOK_PARSE				=	0
	public.HOOK_IGNOREUNKNOWN		=	1	-- parse and ignore unknown commands
	public.HOOK_NOPARSE				=	2

	public.HOOK_TRIGGER				=	0
	public.HOOK_NOTRIGGER			=	1

	public.HOOK_TRIGGERENTITY		=	0
	public.HOOK_NOTRIGGERENTITY		=	1

	public.HOOK_BUY	  				=	0
	public.HOOK_NOBUY	  			=	1

	public.HOOK_WALKOVER			=	0
	public.HOOK_NOWALKOVER			=	1

	public.HOOK_DROP				=	0
	public.HOOK_NODROP				=	1
	--public.HOOK_DROP				=	2	-- drop and never fade out the item

	public.HOOK_DIE					=	0	-- die and drop items normally
	public.HOOK_DROPIMPORTANT		=	1	-- die and only drop bomb and flag

	public.HOOK_SAY					=	0
	public.HOOK_NOSAY				=	1

	public.HOOK_SAYTEAM				=	0
	public.HOOK_NOSAYTEAM			=	1

	public.HOOK_RADIO				=	0
	public.HOOK_NORADIO				=	1

	public.HOOK_LOG					=	0
	public.HOOK_NOLOG				=	1

	public.HOOK_HIT					=	0
	public.HOOK_NOHIT				=	1

	public.HOOK_BUILDATTEMPT		=	0
	public.HOOK_NOBUILDATTEMPT		=	1

	public.HOOK_BUILD				=	0
	public.HOOK_NOBUILD				=	1

	public.HOOK_FLAGTAKE			=	0
	public.HOOK_NOFLAGTAKE			=	1

	public.HOOK_FLAGCAPTURE			=	0
	public.HOOK_NOFLAGCAPTURE		=	1

	public.HOOK_DOMINATE			=	0
	public.HOOK_NODOMINATE			=	1

	public.HOOK_BOMBPLANT			=	0
	public.HOOK_NOBOMBPLANT			=	1

	public.HOOK_BOMBDEFUSE			=	0
	public.HOOK_NOBOMBDEFUSE		=	1

	public.HOOK_BOMBEXPLODE			=	0
	public.HOOK_NOBOMBEXPLODE		=	1

	public.HOOK_RCON				=	0
	public.HOOK_NORCON				=	1

	public.HOOK_OBJECTDAMAGE		=	0
	public.HOOK_NOOBJECTDAMAGE		=	1
end

return pif