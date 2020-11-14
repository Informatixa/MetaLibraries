local function pif(public, name, path)
  function public.split(sep, str)
    local sep, fields = sep or ' ', {}
    local pattern = string.format('([^%s]+)', sep)
    string.gsub(str, pattern, function(c) fields[#fields+1] = c end)
    return fields
  end

  function public.left(str, num)
    return string.sub(str, 1, num)
  end

  function public.right(str, num)
    return string.sub(str, -num)
  end

  function public.trim(s, char)
    if char == nil then char = '%s' end
    return string.gsub(s, '^'.. char ..'*(.-)'.. char ..'*$', '%1')
  end

  function public.rtrim(s, char)
    if char == nil then char = '%s' end
    return string.gsub(s, '^(.-)'.. char ..'*$', '%1')
  end

  function public.ltrim(s, char)
    if char == nil then char = '%s' end
    return string.gsub(s, '^'.. char ..'*(.-)$', '%1')
  end
end

return pif
