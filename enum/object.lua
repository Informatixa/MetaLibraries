local function pif(public, name, path)
  local private = {}

  public.OBJECT_BARRICADE         = 1
  public.OBJECT_BARDED_WIRE       = 2
  public.OBJECT_WALL_I            = 3
  public.OBJECT_WALL_II           = 4
  public.OBJECT_WALL_III          = 5
  public.OBJECT_GATE_FIELD        = 6
  public.OBJECT_DISPENSER         = 7
  public.OBJECT_TURRET            = 8
  public.OBJECT_SUPPLY            = 9
  public.OBJECT_CONSTRUCTION_SITE = 10

  public.OBJECT_DUAL_TURRET         = 11
  public.OBJECT_TRIPLE_TURRET       = 12
  public.OBJECT_TELEPORTER_ENTRANCE = 13
  public.OBJECT_TELEPORTER_EXIT     = 14
  public.OBJECT_SUPER_SUPPLY        = 15

  public.OBJECT_MINE        = 20
  public.OBJECT_LASER_MINE  = 21
  public.OBJECT_PORTAL_RED  = 22
  public.OBJECT_PORTAL_BLUE = 23
end

return pif
