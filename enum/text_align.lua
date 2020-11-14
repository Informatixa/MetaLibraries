local function pif(public, name, path)
  local private = {}

  public.TEXT_ALIGN_LEFT   = 0
  public.TEXT_ALIGN_CENTER = 1
  public.TEXT_ALIGN_RIGHT  = -1
end

return pif
