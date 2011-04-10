local meta = CreateMetaTable("Menu")
local _meta = CreateMetaTable("ButtonData")

menu = {}
player.Menu = {}

hook.Add("join", "PlayerMenuJoin", function(ply)
	player.Menu[ply:UserID()] = {}
end)

function menu.Create(ply, title)
	local Table = CopyMetaTable("Menu")
	
	Table.Control = {}
	Table.Control.Settings = {}
	Table.Control.Buttons = {{}}
	Table.Control.Close = nil
	--Table.Control.Close = {Title = nil, Page = 1}
		
	Table.Settings = {}
	Table.Settings.Player = ply
	Table.Settings.Title = title
	
	player.Menu[ply:UserID()][Table.Settings.Title] = Table
	
	return Table
end

function menu.Find(ply, title)
	for _, v in pairs(player.Menu[ply:UserID()]) do
		if v.Settings.Title == title then
			return v
		end
	end
	
	return nil
end

function menu.Send(ply, title, page)
	local Table = menu.Find(ply, title)
	if Table == nil then return end
	if page == nil or page < 1 or Table.Control.Buttons[page] == nil then page = 1 end
	
	if #Table.Control.Buttons > 1  and Table.Control.Buttons[#Table.Control.Buttons][#Table.Control.Buttons[#Table.Control.Buttons]].text ~= "<- Previous Page" then
		table.insert(Table.Control.Buttons[#Table.Control.Buttons], {text = "<- Previous Page", func = function(ply) menu.Send(Table.Settings.Player, Table.Settings.Title, Table.Control.Settings.Previous) end, extra = "Page ".. tostring(#Table.Control.Buttons - 1), data = {}})
	end
	
	local text = ""
	for k, v in pairs(Table.Control.Buttons[page]) do
		text = text ..",".. v.text .."|".. v.extra
	end
	
	if #Table.Control.Buttons > 1 then 
		_menu(Table.Settings.Player:UserID(), Table.Settings.Title .." (Page ".. page ..")".. text)
	else
		_menu(Table.Settings.Player:UserID(), Table.Settings.Title .. text)
	end
	
	hook.Add("menu", "MenuCore", function(ply, title, button)
		local Table = nil
		
		if string.find(title, "(Page [^*])") ~= nil then
			Table = menu.Find(ply, title:sub(1, string.find(title, "(Page [^*])") - 3))
			page = tonumber(string.replace(title:sub(string.find(title, "(Page [^*])")), "Page ", ""))
		else
			Table = menu.Find(ply, title)
			page = 1
		end
		
		if Table == nil then return end
		
		Table.Control.Settings = {Previous = page - 1, Next = page + 1}
			
		--[[if button == 0 and Table.Control.Close["Title"] ~= nil and Table.Control.Close["Title"] ~= title then
			hook.Remove("menu", "MenuCore")
			menu.Send(Table.Settings.Player, Table.Control.Close["Title"], Table.Control.Close["Page"])
			return
		end--]]
		
		if button == 0 and Table.Control.Close ~= nil then
			hook.Remove("menu", "MenuCore")
			Table.Control.Close(ply)
		end
		
		for k, v in pairs(Table.Control.Buttons[page]) do
			if button == k then
				hook.Remove("menu", "MenuCore")
				v.func(ply, Table.Control.Buttons[page][k].data)
				break
			end
		end
	end)
end

function menu.ButtonData(menu, page, button)
	local Table = CopyMetaTable("ButtonData")
	
	Table.Menu = menu
	Table.Page = page
	Table.Button = button
	
	return Table
end

function _meta:Data(data)
	table.insert(self.Menu.Control.Buttons[self.Page][self.Button].data, data)
end

function meta:SetControlClose(func)
	--if menu.Find(self.Settings.Player, title) == nil then title = nil end
	--if page == nil or page < 1 or menu.Find(self.Settings.Player, title).Control.Buttons[page] == nil then page = 1 end
	--self.Control.Close = {Title = title, Page = page}
	self.Control.Close = func
end

function meta:ButtonAdd(text, func, extra)
	if #self.Control.Buttons > 1 and self.Control.Buttons[#self.Control.Buttons][#self.Control.Buttons[#self.Control.Buttons]].text == "<- Previous Page" then
		table.remove(self.Control.Buttons[#self.Control.Buttons], #self.Control.Buttons[#self.Control.Buttons])
	end
	
	if extra == nil then extra = "" end
	if #self.Control.Buttons[#self.Control.Buttons] < 9 then
		table.insert(self.Control.Buttons[#self.Control.Buttons], {text = tostring(text), func = func, extra = tostring(extra), data = {}})
	else
		table.insert(self.Control.Buttons, {})
		local page = self.Control.Buttons[#self.Control.Buttons - 1]
		if #self.Control.Buttons == 2 then
			table.insert(page, {text = "Next Page ->", func = function(ply) menu.Send(self.Settings.Player, self.Settings.Title, self.Control.Settings.Next) end, extra = "Page ".. tostring(#self.Control.Buttons), data = {}})
			table.insert(self.Control.Buttons[#self.Control.Buttons], {text = page[9].text, func = page[9].func, extra = page[9].extra, data = {}})
			table.remove(page, 9)
		else
			table.insert(page, {text = "<- Previous Page", func = function(ply) menu.Send(self.Settings.Player, self.Settings.Title, self.Control.Settings.Previous) end, extra = "Page ".. tostring(#self.Control.Buttons - 2), data = {}})
			table.insert(page, {text = "Next Page ->", func = function(ply) menu.Send(self.Settings.Player, self.Settings.Title, self.Control.Settings.Next) end, extra = "Page ".. tostring(#self.Control.Buttons), data = {}})
			table.insert(self.Control.Buttons[#self.Control.Buttons], {text = page[8].text, func = page[8].func, extra = page[8].extra, data = {}})
			table.insert(self.Control.Buttons[#self.Control.Buttons], {text = page[9].text, func = page[9].func, extra = page[9].extra, data = {}})
			table.remove(page, 8)
			table.remove(page, 8)
		end
		table.insert(self.Control.Buttons[#self.Control.Buttons], {text = tostring(text), func = func, extra = tostring(extra), data = {}})
	end
	
	return menu.ButtonData(self, #self.Control.Buttons, #self.Control.Buttons[#self.Control.Buttons])
end

function meta:Send()
	menu.Send(self.Settings.Player, self.Settings.Title)
end
