local util = import(METALIBDIR ..'/util.lua')
local mod_file = import(METALIBDIR ..'/modules/file.lua')
local ext_string = import(METALIBDIR ..'/extensions/string.lua')

local function pif(public, name, path)
  local private = {}
  private.Ini = util.CreateMetaTable('Ini')

  function public.Open(filename)
    local Table = util.CopyMetaTable('Ini')

    Table.Name = filename
    Table.File = mod_file.Read(filename) or ''

    return Table
  end

  function private.Ini:Save()
    local results = self:Parse()
    local text = ''

    for k, v in pairs(results) do
      text = text ..'['.. tostring(k) ..']\r'

      for k2, v2 in pairs(v) do
        text = text .. tostring(k2) ..'='.. tostring(v2) ..'\r'
      end

      text = text ..'\n'
    end

    mod_file.Write(self.Name, text, 'w+')
  end

  function private.Ini:GetValue(block, key)
    local results = self:Parse()

    for k, v in pairs(results) do
      if (k == block) then
        for k2, v2 in pairs(v) do
          if (k2 == key) then return v2 end
        end
      end
    end

    return ''
  end

  function private.Ini:SetValue(block, key, value)
    local results = self:Parse()

    if results[block] == nil then
      results[block] = {}
    end

    results[block][key] = value
  end

  function private.Ini:GetBlock(block)
    local results = self:Parse()

    for k, v in pairs(results) do
      if (k == block) then return v end
    end

    return {}
  end

  function private.Ini:SetBlock(block, content)
    local results = self:Parse()

    results[block] = content
  end

  function private.Ini:Parse()
    if self.Results then return self.Results end
    self.Results = {}

    local current = ''
    local exploded = ext_string.split('\n', self.File)

    for k, v in pairs(exploded) do
      if (string.sub(v, 1, 1) ~= '#') then
        local line = ext_string.trim(ext_string.rtrim(v, '%r'))

        if not util.empty(line) then
          if (string.sub(line, 1, 1) == '[') then
            local _end = string.find(line, '%]')

            if (_end) then
              local block = string.sub(line, 2, _end - 1)

              self.Results[block] = self.Results[block] or {}
              current = block
            end
          else
            self.Results[current] = self.Results[current] or {}

            if not util.empty(current) then
              line = ext_string.split('=', line)

              if (table.count(line) == 2) then
                local key = ext_string.trim(line[1])
                local value = ext_string.trim(ext_string.trim(line[2]), '"')

                self.Results[current][key] = value
              elseif (table.count(line) == 1) then
                local value = ext_string.trim(ext_string.trim(line[1]), '"')

                self.Results[current][#self.Results[current] + 1] = value
              end
            end
          end
        end
      end
    end

    return self.Results
  end
end

return pif
