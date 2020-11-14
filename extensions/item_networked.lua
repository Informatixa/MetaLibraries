local meta = FindMetaTable("Item")
if not meta then return end

item.Networked = {}

function meta:GetNetworked(name)
  if item.Networked[self:ID()][name] ~= nil then
    return item.Networked[self:ID()][name]
  else
    return nil
  end
end

function meta:SetNetworked(name, value)
  item.Networked[self:ID()][name] = value
end

hook.Add("always", "ItemNetworked", function()
  for _, v in pairs(item.GetAll()) do
    if item.Networked[v:ID()] == nil then
      item.Networked[v:ID()] = {}
    end
  end
end)

--[[hook.Add("collect", "ItemNetworked", function(ply, i, type, ain, a, mode)
  item.Networked[i:ID()] = {}
end)--]]
