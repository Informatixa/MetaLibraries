meta = CreateMetaTable("Ini")

ini = {}

function ini.Open(filename)
	local Table = meta
	
	Table.Name = filename
	Table.File = file.Read(filename) or ""
	
	return Table
end

function meta:Save()
	local results = self:Parse()
	local text = ""

	for k, v in pairs(results) do
		text += "[".. k .."]"
		
		for k2, v2 in pairs(v) do
			text += k2 .."=".. v2
		end
	end
	
	file.Write(self.Name, text)
end

function meta:GetValue(block, key)
	local results = self:Parse()
	
	for k, v in pairs(results) do
		if (k == block) then
			for k2, v2 in pairs(v) do
				if (k2 == key) then return v2 end
			end
		end
	end
	
	return ""
end

function meta:GetBlock(block)
	local results = self:Parse()
	
	for k, v in pairs(results) do
		if (k == block) then return v end
	end
	
	return {}
end

function meta:Parse()
	if self.Results then return self.Results end
	self.Results = {}
	
	local current = ""
	local exploded = string.explode("\n", self.File)
	
	for k, v in pairs(exploded) do
		if (string.sub(v, 1, 1) ~= "#") then
			local line = string.trim(v)
			
			if (line ~= "") then
				if (string.sub(line, 1, 1) == "[") then
					local _end = string.find(line, "%]")
					
					if (_end) then
						local block = string.sub(line, 2, _end - 1)
						
						self.Results[block] = self.Results[block] or {}
						current = block
					end
				else
					self.Results[current] = self.Results[current] or {}
					
					if (current ~= "") then
						line = string.explode("=", line)
						
						if (table.Count(line) == 2) then
							local key = string.trim(line[1])
							local value = string.trim(line[2])
							
							self.Results[current][key] = value
						elseif (table.Count(line) == 1) then
							local value = string.trim(line[1])
							
							self.Results[current][#self.Results[current] + 1] = value
						end
					end
				end
			end
		end
	end
	
	return self.Results
end