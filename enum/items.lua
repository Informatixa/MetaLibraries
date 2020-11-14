local function pif(public, name, path)
	local private = {}

	public.ITEM_USP     			=	1
	public.ITEM_GLOCK   			=	2
	public.ITEM_DEAGLE				=	3
	public.ITEM_P228				=	4
	public.ITEM_ELITE				=	5
	public.ITEM_FIVESEVEN			=	6

	public.ITEM_M3					=	10
	public.ITEM_XM1014				=	11

	public.ITEM_MP5					=	20
	public.ITEM_TMP					=	21
	public.ITEM_P90					=	22
	public.ITEM_MAC10				=	23
	public.ITEM_UMP45				=	24

	public.ITEM_AK47				=	30
	public.ITEM_SG552				=	31
	public.ITEM_M4A1				=	32
	public.ITEM_AUG					=	33
	public.ITEM_SCOUT				=	34
	public.ITEM_AWP					=	35
	public.ITEM_G3SG1				=	36
	public.ITEM_SG550				=	37
	public.ITEM_GALIL				=	38
	public.ITEM_FAMAS				=	39

	public.ITEM_M249				=	40
	public.ITEM_TACTICALSHIELD		=	41
	public.ITEM_LASER				=	45
	public.ITEM_FLAMETHROWER		=	46
	public.ITEM_RPGLAUNCHER			=	47
	public.ITEM_ROCKETLAUNCHER		=	48
	public.ITEM_GRENADELAUNCHER		=	49

	public.ITEM_KNIFE 				=	50
	public.ITEM_HE					=	51
	public.ITEM_FLASHBANG			=	52
	public.ITEM_SMOKEGRENADE		=	53
	public.ITEM_FLARE				=	54
	public.ITEM_BOMB				=	55
	public.ITEM_DEFUSEBIT			=	56
	public.ITEM_KEVLAR				=	57
	public.ITEM_KEVLARHELM			=	58
	public.ITEM_NIGHTVISION			=	59

	public.ITEM_GASMASK				=	60
	public.ITEM_PRIMARYAMMO			=	61
	public.ITEM_SECONDARYAMMO		=	62
	public.ITEM_PLANTEDBOMB			=	63
	public.ITEM_MEDIKIT				=	64
	public.ITEM_BANDAGE				=	65
	public.ITEM_COINS				=	66
	public.ITEM_MONEY				=	67
	public.ITEM_GOLD				=	68
	public.ITEM_MACHETE				=	69
	
	public.ITEM_GASGRENADE			=	72
	public.ITEM_MOLOTOVCOCKTAIL		=	73
	public.ITEM_WRENCH				=	74
	public.ITEM_SNOWBALL			=	75
	public.ITEM_AIRSTRIKE			=	76
	public.ITEM_MINE				=	77
	public.ITEM_CLAW				=	78
	public.ITEM_LIGHTARMOR			=	79
	
	public.ITEM_ARMOR				=	80
	public.ITEM_HEAVYARMOR			=	81
	public.ITEM_MEDICARMOR			=	82
	public.ITEM_SUPERARMOR			=	83
	public.ITEM_STEALTHSUIT			=	84
	public.ITEM_CHAINSAW			=	85
	public.ITEM_GUTBOMB				=	86
	public.ITEM_LASERMINE			=	87
	public.ITEM_PORTALGUN			=	88
	public.ITEM_SATCHELCHARGE		=	89
	
	public.ITEM_M134				=	90
	public.ITEM_FN2000				=	91
	
	public.DEADLY_NORMAL			=	240
	public.DEADLY_EXPLOTION			=	241
	public.DEADLY_TOXIC				=	242
	public.DEADLY_ABYSS				=	243
	
	public.KILL_CUSTOM				=	250
	public.KILL_EXPLOTION			=	251
	public.KILL_TURRET				=	253
	public.KILL_GATEFIELD			=	254
	public.KILL_BARBEDWIRE			=	255
end

return pif