local util = import(METALIBDIR ..'/util.lua')

local function pif(public, name, path)
	local private = {}
	private.CreateObject = util.CreateMetaTable('CreateObject')
	private.Object = util.CreateMetaTable('Object')

	
	function public.Create(type)
		local Table = util.CopyMetaTable('CreateObject')
		if type == nil then type = 10 end
		Table.Type = type
		Table.Pos = Vector(0, 0)
		Table.Ang = 0
		Table.Mode = 0
		if type == 9 then Table.Mode = 1 end
		Table.Team = 0
		Table.Player = 0
		return Table
	end

	function public.GetByID(index)
		if index == 0 or not util.tobool(object(index, 'exists')) then return nil end
		local Table = util.CopyMetaTable('Object')
		Table.Index = index
		return Table
	end

	function public.GetAll()
		local Table = {}
		for k, v in pairs(object(0, 'table')) do
			table.insert(Table, public.GetByID(v))
		end
		return Table
	end
	
	function public.FindByType(type)
		if type == nil then type = 10 end
		local Table = {}
		for k, v in pairs(public.GetAll()) do
			if v:GetType() == type then
				table.insert(Table, v)
			end
		end
		return Table
	end
	
	function public.GetByPos(tilex, tiley)
		for k, v in pairs(public.GetAll()) do
			if v:GetPos().x == tilex and v:GetPos().y == tiley then
				return v
			end
		end
		return nil
	end

	function private.Object:GetID()
		return self.Index
	end

	function private.Object:GetType()
		return object(self:GetID(), 'type')
	end
	function private.Object:GetTypeName()
		return object(self:GetID(), 'typename')
	end

	function private.Object:GetPos()
		return Vector(object(self:GetID(), 'tilex'), object(self:GetID(), 'tiley'))
	end

	function private.CreateObject:SetPos(tilex, tiley)
		self.Pos = Vector(tilex, tiley)
	end

	function private.Object:GetTeam()
		return object(self:GetID(), 'team')
	end

	function private.CreateObject:SetTeam(index)
		self.Team = index
	end

	function private.Object:GetHealth()
		return object(self:GetID(), 'health')
	end

	function private.Object:GetAng()
		return object(self:GetID(), 'rot')
	end

	function private.CreateObject:SetAng(ang)
		self.Ang = ang
	end

	function private.Object:GetOwner()
		return player.GetByID(object(self:GetID(), 'player'))
	end

	function private.CreateObject:SetOwner(index)
		self.Player = index
	end

	function private.Object:GetMode()
		return object(self:GetID(), 'mode')
	end

	function private.CreateObject:SetMode(id)
		if id == nil then id = 1 end
		self.Mode = id
	end

	function private.CreateObject:Spawn()
		parse(string.format('spawnobject %d %d %d %d %d %d %d', self.Type, self.Pos.x, self.Pos.y, self.Ang, self.Mode, self.Team, self.Player))
		local obj = public.GetByPos(self.Pos.x, self.Pos.y)
		if obj ~= nil then
			self.Index = obj:GetID()
			if self.Index ~= nil then
				function self:GetID()
					return self.Index
				end
			end
		end
	end
end

return pif