local meta = CreateMetaTable("Menu")

menu = {}
menu.Table = {}

function menu.Create()
	local Table = meta
	
	Table.Control = {}
	Table.Control.Settings = {}
	Table.Control.Buttons = {{}}
	Table.Control.Close = {Title = title, Page = 1}
	
	Table.Settings = {}
	Table.Settings.Player = 0
	Table.Settings.Title = "N/A"
	
	table.insert(menu.Table, Table)
	
	return Table
end

function menu.Find(title)
	for _, v in pairs(menu.Table) do
		if v.Settings.Title == title then
			return v
		end
	end
	
	return nil
end

function menu.Send(title, page)
	local Table = menu.Find(title)
	if Table == nil then return end
	if page == nil or page < 1 or Table.Control.Buttons[page] == nil then page = 1 end
	
	if #Table.Control.Buttons > 1  and Table.Control.Buttons[#Table.Control.Buttons][#Table.Control.Buttons[#Table.Control.Buttons]].text ~= "<- Previous Page" then
		table.insert(Table.Control.Buttons[#Table.Control.Buttons], {text = "<- Previous Page", func = function(ply) menu.Send(Table.Settings.Title, Table.Control.Settings.Previous) end, extra = "Page ".. tostring(#Table.Control.Buttons - 1)})
	end
	
	local text = ""
	for k, v in pairs(Table.Control.Buttons[page]) do
		text = text ..",".. v.text .."|".. v.extra
	end
	
	if #Table.Control.Buttons > 1 then 
		_menu(Table.Settings.Player, Table.Settings.Title .." (Page ".. page ..")".. text)
	else
		_menu(Table.Settings.Player, Table.Settings.Title .. text)
	end
	
	hook.Add("menu", "MenuCore", function(ply, title, button)
		local Table = menu.Find(title:sub(1, string.find(title, "(Page [^*])") - 3))
		if Table == nil then return end
		
		if string.find(title, "(Page [^*])") ~= nil then
			page = string.replace(title:sub(string.find(title, "(Page [^*])")), "Page ", "")
		else
			page = 1
		end
		
		Table.Control.Settings = {Previous = page - 1, Next = page + 1}
		
		for k, v in pairs(Table.Control.Buttons[tonumber(page)]) do
			if button == k then
				hook.Remove("menu", "MenuCore")
				v.func(ply)
				return
			end
		end
	end)
end

function meta:SetPlayer(ply)
	self.Settings.Player = ply:UserID()
end

function meta:SetTitle(title)
	self.Settings.Title = title
end

function meta:SetControlClose(title, page)
	if menu.Find(title) == nil then title = nil end
	if page == nil or page < 1 or menu.Find(title).Control.Buttons[page] == nil then page = 1 end
	Table.Control.Close = {Title = title, Page = page}
end

function meta:ButtonAdd(text, func, extra)
	if #self.Control.Buttons > 1 and self.Control.Buttons[#self.Control.Buttons][#self.Control.Buttons[#self.Control.Buttons]].text == "<- Previous Page" then
		table.remove(self.Control.Buttons[#self.Control.Buttons], #self.Control.Buttons[#self.Control.Buttons])
	end
	
	if extra == nil then extra = "" end
	if #self.Control.Buttons[#self.Control.Buttons] < 9 then
		table.insert(self.Control.Buttons[#self.Control.Buttons], {text = tostring(text), func = func, extra = tostring(extra)})
	else
		table.insert(self.Control.Buttons, {})
		local page = self.Control.Buttons[#self.Control.Buttons - 1]
		if #self.Control.Buttons == 2 then
			table.insert(page, {text = "Next Page ->", func = function(ply) menu.Send(self.Settings.Title, self.Control.Settings.Next) end, extra = "Page ".. tostring(#self.Control.Buttons)})
			table.insert(self.Control.Buttons[#self.Control.Buttons], {text = page[9].text, func = page[9].func, extra = page[9].extra})
			table.remove(page, 9)
		else
			table.insert(page, {text = "<- Previous Page", func = function(ply) menu.Send(self.Settings.Title, self.Control.Settings.Previous) end, extra = "Page ".. tostring(#self.Control.Buttons - 2)})
			table.insert(page, {text = "Next Page ->", func = function(ply) menu.Send(self.Settings.Title, self.Control.Settings.Next) end, extra = "Page ".. tostring(#self.Control.Buttons)})
			table.insert(self.Control.Buttons[#self.Control.Buttons], {text = page[8].text, func = page[8].func, extra = page[8].extra})
			table.insert(self.Control.Buttons[#self.Control.Buttons], {text = page[9].text, func = page[9].func, extra = page[9].extra})
			table.remove(page, 8)
			table.remove(page, 8)
		end
		table.insert(self.Control.Buttons[#self.Control.Buttons], {text = tostring(text), func = func, extra = tostring(extra)})
	end
end

function meta:Send()
	menu.Send(self.Settings.Title)
end
