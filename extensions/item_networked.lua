local util = import(METALIBDIR ..'/util.lua')
local mod_hook = import(METALIBDIR ..'/modules/hook.lua')
local ext_item = import(METALIBDIR ..'/extensions/item.lua')

MetaLibrariesConst.ItemNetworked = {}

local function pif(public, name, path)
  local private = {}
  private.Item = util.FindMetaTable('Item')

  function private.Item:GetNetworked(name)
    if MetaLibrariesConst.ItemNetworked[self:ID()] ~= nil and MetaLibrariesConst.ItemNetworked[self:ID()][name] ~= nil then
      return MetaLibrariesConst.ItemNetworked[self:ID()][name]
    else
      return nil
    end
  end

  function private.Item:SetNetworked(name, value)
    MetaLibrariesConst.ItemNetworked[self:ID()][name] = value
  end

  mod_hook.Add('always', 'ItemNetworked', function()
    for k, v in pairs(ext_item.GetAll()) do
      if MetaLibrariesConst.ItemNetworked[v:ID()] == nil then
        MetaLibrariesConst.ItemNetworked[v:ID()] = {}
      end
    end
  end)
end

return pif

--[[hook.Add("collect", "ItemNetworked", function(ply, i, type, ain, a, mode)
  item.Networked[i:ID()] = {}
end)--]]
