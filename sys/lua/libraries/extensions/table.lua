tablex = table

function table.inherit(t, base)
	for k, v in pairs(base) do 
		if (t[k] == nil) then t[k] = v end
	end
	
	t["BaseClass"] = base
	
	return t
end

function table.copy(t, lookup_table)
	if (t == nil) then return nil end
	
	local copy = {}
	
	setmetatable(copy, getmetatable(t))
	
	for i,v in pairs(t) do
		if type(v) ~= "table" then
			copy[i] = v
		else
			lookup_table = lookup_table or {}
			lookup_table[t] = copy
			
			if lookup_table[v] then
				copy[i] = lookup_table[v]
			else
				copy[i] = table.copy(v, lookup_table)
			end
		end
	end
	
	return copy
end

function table.empty(tab)
	for k, v in pairs(tab) do
		tab[k] = nil
	end
end

function table.copyfromto(FROM, TO)
	table.empty(TO)
	
	table.merge(TO, FROM)
end

function table.merge(dest, source)
	for k,v in pairs(source) do
	
		if (type(v) == "table" and type(dest[k]) == "table") then
			table.merge(dest[k], v)
		else
			dest[k] = v
		end
	end
	
	return dest
end

function table.hasvalue(t, val)
	for k,v in pairs(t) do
		if (v == val) then return true end
	end
	
	return false
end

table.intable = hasvalue

function table.add(dest, source)
	if (type(source) ~= 'table') then return dest end
	
	if (type(dest) ~= 'table') then dest = {} end

	for k,v in pairs(source) do
		table.insert(dest, v)
	end
	
	return dest
end

function table.sortdesc(Table)
	return table.sort(Table, function(a, b) return a > b end)
end

function table.sortbykey(Table, Desc)
	local temp = {}

	for key, _ in pairs(Table) do table.insert(temp, key) end
	
	if (Desc) then
		table.sort(temp, function(a, b) return Table[a] < Table[b] end)
	else
		table.sort(temp, function(a, b) return Table[a] > Table[b] end)
	end

	return temp
end

function table.count(t)
	return #t
end

function table.random(t)
	local rk = math.random(1, table.count(t))
	local i = 1
	
	for k, v in pairs(t) do 
		if (i == rk) then return v end
		
		i = i + 1 
	end
end

function table.issequential(t)
	local i = 1
	
	for key, value in pairs (t) do
		if not tonumber(i) or key ~= i then return false end
		
		i = i + 1
	end
	
	return true
end

function table.tostring(t, n, nice)
	local nl,tab = "", ""
	
	if nice then nl, tab = "\n", "\t" end

	local function MakeTable(t, nice, indent, done)
		local str = ""
		local done = done or {}
		local indent = indent or 0
		local idt = ""
		
		if nice then idt = string.rep("\t", indent) end

		local sequential = table.issequential(t)

		for key, value in pairs(t) do
			str = str .. idt .. tab .. tab

			if not sequential then
				if type(key) == "number" or type(key) == "boolean" then 
					key ='['..tostring(key)..']' ..tab..'='
				else
					key = tostring(key) ..tab..'='
				end
			else
				key = ""
			end

			if type(value) == "table" and not done[value] then
				done[value] = true
				str = str .. key .. tab .. '{' .. nl
				.. MakeTable (value, nice, indent + 1, done)
				str = str .. idt .. tab .. tab ..tab .. tab .."},".. nl
			else
				if 	type(value) == "string" then 
					value = '"'..tostring(value)..'"'
				else
					value = tostring(value)
				end
				
				str = str .. key .. tab .. value .. ",".. nl
			end
		end
		
		return str
	end
	
	local str = ""
	
	if n then str = n.. tab .."=" .. tab end
	
	str = str .."{" .. nl .. MakeTable(t, nice) .. "}"
	
	return str
end

function table.sanitise(t, done)
	local done = done or {}
	local tbl = {}

	for k, v in pairs(t) do
		if (type(v) == "table" and not done[v]) then
			done[v] = true
			tbl[k] = table.sanitise(v, done)
		else
			if (type(v) == "boolean") then
				tbl[k] = { __type = "Bool", tostring(v)}
			else
			
				tbl[k] = tostring(v)
			end
		end
	end
	
	return tbl
end

function table.desanitise(t, done)
	local done = done or {}
	local tbl = {}

	for k, v in pairs(t) do
		if (type( v ) == "table" and not done[v]) then
			done[ v ] = true

			if (v.__type) then
				if (v.__type == "Bool") then
					tbl[k] = (v[1] == "true")
				end
			else
				tbl[k] = table.desanitise(v, done)
			end
		else
			tbl[k] = v
		end
	end
	
	return tbl
end

function table.forceinsert(t, v)
	if (t == nil) then t = {} end
	
	table.insert(t, v)
end

function table.sortbymember(Table, MemberName, bAsc)
	local TableMemberSort = function(a, b, MemberName, bReverse)
		if (type(a) ~= "table") then return not bReverse end
		if (type(b) ~= "table") then return bReverse end
		if not (a[MemberName]) then return not bReverse end
		if not (b[MemberName]) then return bReverse end
	
		if (bReverse) then
			return a[MemberName] < b[MemberName]
		else
			return a[MemberName] > b[MemberName]
		end
		
	end

	table.sort(Table, function(a, b) return TableMemberSort(a, b, MemberName, bAsc or false) end)
end

function table.lowerkeynames(Table)
	local OutTable = {}

	for k, v in pairs(Table) do
		if (type(v) == "table") then
			v = table.lowerkeynames(v)
		end
		
		OutTable[k] = v
		
		if (type(k) == "string") then
	
			OutTable[k]  = nil
			OutTable[string.lower(k)] = v
		
		end		
	end
	
	return OutTable
end

function table.collapsekeyvalue(Table)
	local OutTable = {}
	
	for k, v in pairs(Table) do
		local Val = v.Value
	
		if (type(Val) == "table") then
			Val = table.collapsekeyvalue(Val)
		end
		
		OutTable[v.Key] = Val
	end
	
	return OutTable
end

function table.clearkeys(Table, bSaveKey)
	local OutTable = {}
	
	for k, v in pairs(Table) do
		if (bSaveKey) then
			v.__key = k
		end
		table.insert(OutTable, v)	
	end
	
	return OutTable
end

local function fnPairsSorted(pTable, Index)
	if (Index == nil) then
		Index = 1
	else
		for k, v in pairs(pTable.__SortedIndex) do
			if (v == Index) then
				Index = k + 1
				break
			end
		end
	end
	
	local Key = pTable.__SortedIndex[Index]
	
	if not (Key) then
		pTable.__SortedIndex = nil
		return
	end
	
	Index = Index + 1
	
	return Key, pTable[ Key ]
end

function SortedPairs(pTable, Desc)
	pTable = table.copy(pTable)
	
	local SortedIndex = {}
	for k, v in pairs(pTable) do
		table.insert(SortedIndex, k)
	end
	
	if (Desc) then
		table.sort(SortedIndex, function(a, b) return a > b end)
	else
		table.sort(SortedIndex)
	end
	
	pTable.__SortedIndex = SortedIndex

	return fnPairsSorted, pTable, nil
end

function SortedPairsByValue(pTable, Desc)
	pTable = table.clearkeys(pTable)
	
	if (Desc) then
		table.sort(pTable, function(a, b) return a > b end)
	else
		table.sort(pTable)
	end

	return ipairs(pTable)
end

function SortedPairsByMemberValue(pTable, pValueName, Desc)
	Desc = Desc or false
	
	local pSortedTable = table.clearkeys(pTable, true)
	
	table.sortbymember(pSortedTable, pValueName, not Desc)
	
	local SortedIndex = {}
	for k, v in ipairs(pSortedTable) do
		table.insert(SortedIndex, v.__key)
	end
	
	pTable.__SortedIndex = SortedIndex

	return fnPairsSorted, pTable, nil
end

function RandomPairs(pTable, Desc)
	local Count = table.count(pTable)
	pTable = table.copy(pTable)
	
	local SortedIndex = {}
	for k, v in pairs(pTable) do
		table.insert(SortedIndex, {key = k, val = math.random(1, 1000)})
	end
	
	if (Desc) then
		table.sort(SortedIndex, function(a, b) return a.val > b.val end)
	else
		table.sort(SortedIndex, function(a, b) return a.val < b.val end)
	end
	
	for k, v in pairs(SortedIndex) do
		SortedIndex[k] = v.key;
	end
	
	pTable.__SortedIndex = SortedIndex

	return fnPairsSorted, pTable, nil
end

function table.getfirstkey(t)
	local k, v = next(t)
	
	return k
end

function table.getfirstvalue(t)
	local k, v = next(t)
	
	return v
end

function table.getlastkey(t)
	local k, v = next(t, table.count(t))
	
	return k
end

function table.getlastvalue(t)
	local k, v = next(t, table.count(t))
	
	return v
end

function table.findnext(tab, val)
	local bfound = false
	
	for k, v in pairs(tab) do
		if (bfound) then return v end
		if (val == v) then bfound = true end
	end
	
	return table.getfirstvalue(tab)	
end

function table.findprev(tab, val)
	local last = table.getlastvalue(tab)
	
	for k, v in pairs(tab) do
		if (val == v) then return last end
		last = v
	end
	
	return last
end

function table.getwinningkey(tab)
	local highest = -10000
	local winner = nil
	
	for k, v in pairs(tab) do
		if (v > highest) then 
			winner = k
			highest = v
		end
	end
	
	return winner
end
