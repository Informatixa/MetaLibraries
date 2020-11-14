local enum_item = import(METALIBDIR ..'/enum/items.lua')
local enum_print_type = import(METALIBDIR ..'/enum/print_types.lua')
local enum_team = import(METALIBDIR ..'/enum/teams.lua')
local enum_text_align = import(METALIBDIR ..'/enum/text_align.lua')
local util = import(METALIBDIR ..'/util.lua')
local ext_weapon = import(METALIBDIR ..'/extensions/weapon.lua')

local function pif(public, name, path)
  local private = {}
  private.Player = util.CreateMetaTable('Player')

  function public.Exists(id)
    if not util.tobool(id) then return false end
    return player(id, 'exists')
  end

  function public.GetByID(id)
    if not public.Exists(id) then return nil end
    local Table = util.CopyMetaTable('Player')
    Table.UserID = id
    return Table
  end

  function public.Rcon(id, ip, port)
    local Table = util.CopyMetaTable('Player')
    Table.UserID = id
    Table.IP = ip
    Table.Port = port
    return Table
  end

  function public.GetAll()
    local players = {}
    for _, v in pairs(player(0, 'table')) do
      table.insert(players, public.GetByID(v))
    end
    return players
  end

  function public.GetAllLiving()
    local players = {}
    for _, v in pairs(player(0, 'tableliving')) do
      table.insert(players, public.GetByID(v))
    end
    return players
  end

  function public.GetByUsgnID(usgn)
    for _, ply in pairs(public.GetAll()) do
      if ply:UsgnID() == usgn then
        return ply
      end
    end
    return nil
  end

  function public.GetBots()
    local bots = {}
    for _, ply in pairs(public.GetAll()) do
      if ply:IsBot() then
        table.insert(bots, ply)
      end
    end
    return bots
  end

  function public.GetBotsLiving()
    local bots = {}
    for _, ply in pairs(public.GetAllLiving()) do
      if ply:IsBot() then
        table.insert(bots, ply)
      end
    end
    return bots
  end

  function public.GetHumansLiving()
    local players = {}
    for _, ply in pairs(public.GetAllLiving()) do
      if ply:IsPlayer() then
        table.insert(players, ply)
      end
    end
    return players
  end

  function public.GetHumans()
    local players = {}
    for _, ply in pairs(public.GetAll()) do
      if ply:IsPlayer() then
        table.insert(players, ply)
      end
    end
    return players
  end

  function public.UnBan(text)
    RunConsoleCommand(string.format('unban %s', text))
  end

  function private.Player:Online()
    if self:UserID() == 0 then return true end
    return public.Exists(self:UserID())
  end

  function private.Player:UserID()
    return self.UserID
  end

  function private.Player:UsgnID()
    if self:UserID() == 0 then
      return 0
    else
      return player(self:UserID(), 'usgn')
    end
  end

  function private.Player:Ban(duration)
    if self:UsgnID() == 0 then
      if duration == nil then
        RunConsoleCommand(string.format('banip %s', self:IPAddress()))
      else
        RunConsoleCommand(string.format('banip %s %s', self:IPAddress(), duration))
      end
    else
      if duration == nil then
        RunConsoleCommand(string.format('banusgn %s', self:UsgnID()))
      else
        RunConsoleCommand(string.format('banusgn %s %s', self:UsgnID(), duration))
      end
    end
  end

  function private.Player:TempBan()
    if self:UsgnID() == 0 then
      RunConsoleCommand(string.format('banip %s -1', self:IPAddress()))
    else
      RunConsoleCommand(string.format('banusgn %s -1', self:UsgnID()))
    end
  end

  function private.Player:BanName(duration)
    if self:UserID() ~= 0 then
      if duration == nil then
        RunConsoleCommand(string.format('banname %s', self:Name()))
      else
        RunConsoleCommand(string.format('banname %s %s', self:Name(), duration))
      end
    end
  end

  function private.Player:TempBanName()
    if self:UserID() ~= 0 then
      RunConsoleCommand(string.format('banname %s -1', self:Name()))
    end
  end

  function private.Player:Kick(reason)
    if self:UserID() ~= 0 then
      if reason == nil then
        RunConsoleCommand(string.format('kick %s', self:UserID()))
      else
        RunConsoleCommand(string.format('kick %s %s', self:UserID(), reason))
      end
    end
  end

  function private.Player:Kill(killer, wpn)
    if self:UserID() ~= 0 and self:Alive() then
      if util.empty(killer) or util.empty(public.GetByID(killer:UserID())) then killer = 0 else killer = killer:UserID() end
      if util.empty(wpn) or util.empty(weapon.GetByType(wpn:Type())) then
        wpn = weapon.GetByType(enum_item.ITEM_KNIFE):Name()
      else
        if type(wpn) ~= 'string' then
          wpn = wpn:Name()
        end
      end
      RunConsoleCommand(string.format('customkill %s %s %s', killer, wpn, self:UserID()))
    end
  end

  function private.Player:Die()
    if self:UserID() ~= 0 and self:Alive() then
      RunConsoleCommand(string.format('killplayer %s', self:UserID()))
    end
  end

  function private.Player:SetHealth(amount)
    if self:UserID() ~= 0 then
      RunConsoleCommand(string.format('sethealth %s %s', self:UserID(), amount))
    end
  end

  function private.Player:SetArmor(amount)
    if self:UserID() ~= 0 then
      RunConsoleCommand(string.format('setarmor %s %s', self:UserID(), amount))
    end
  end

  function private.Player:SetSpeed(amount)
    if self:UserID() ~= 0 then
      RunConsoleCommand(string.format('speedmod %s %s', self:UserID(), amount))
    end
  end

  function private.Player:SetMoney(amount)
    if self:UserID() ~= 0 then
      RunConsoleCommand(string.format('setmoney %s %s', self:UserID(), amount))
    end
  end

  function private.Player:SetDeaths(amount)
    if self:UserID() ~= 0 then
      RunConsoleCommand(string.format('setdeaths %s %s', self:UserID(), amount))
    end
  end

  function private.Player:SetScores(amount)
    if self:UserID() ~= 0 then
      RunConsoleCommand(string.format('setscore %s %s', self:UserID(), amount))
    end
  end

  function private.Player:Alive()
    if self:UserID() == 0 then
      return 0
    else
      return util.tobool(self:Health())
    end
  end

  function private.Player:Health()
    if self:UserID() == 0 then
      return 0
    else
      return player(self:UserID(), 'health')
    end
  end

  function private.Player:MaxHealth()
    if self:UserID() == 0 then
      return 0
    else
      return player(self:UserID(), 'maxhealth')
    end
  end

  function private.Player:Armor()
    if self:UserID() == 0 then
      return 0
    else
      return player(self:UserID(), 'armor')
    end
  end

  function private.Player:Deaths()
    if self:UserID() == 0 then
      return 0
    else
      return player(self:UserID(), 'deaths')
    end
  end

  function private.Player:Scores()
    if self:UserID() == 0 then
      return 0
    else
      return player(self:UserID(), 'score')
    end
  end

  function private.Player:IPAddress()
    if self:UserID() == 0 then
      return self.IP
    else
      return player(self:UserID(), 'ip')
    end
  end

  function private.Player:Pos()
    if self:UserID() == 0 then
      return util.Vector(0, 0)
    else
      return util.Vector(player(self:UserID(), 'x'), player(self:UserID(), 'y'))
    end
  end

  function private.Player:GetPos()
    return self:Pos()
  end

  function private.Player:SetPos(x, y)
    if self:UserID() ~= 0 then
      RunConsoleCommand(string.format('setpos %s %s %s', self:UserID(), x, y))
    end
  end

  function private.Player:Tile()
    if self:UserID() == 0 then
      return util.Vector(0, 0)
    else
      return util.Vector(player(self:UserID(), 'tilex'), player(self:UserID(), 'tiley'))
    end
  end

  function private.Player:GetTile()
    return self:Tile()
  end

  function private.Player:SetTile(tilex, tiley)
    if self:UserID() ~= 0 then
      local pos = convert.pos(tonumber(tilex), tonumber(tiley))
      RunConsoleCommand(string.format('setpos %s %s %s', self:UserID(), pos.x, pos.y))
    end
  end

  function private.Player:Name()
    if self:UserID() == 0 then
      return 'Server'
    else
      return player(self:UserID(), 'name')
    end
  end

  function private.Player:GetName()
    return self:Name()
  end

  function private.Player:SetName(name)
    if self:UserID() ~= 0 then
      RunConsoleCommand(string.format('setname %s %s', self:UserID(), name))
    end
  end

  function private.Player:Ping()
    if self:UserID() == 0 then
      return 0
    else
      return player(self:UserID(), 'ping')
    end
  end

  function private.Player:Speed()
    if self:UserID() == 0 then
      return 0
    else
      return player(self:UserID(), 'speedmod')
    end
  end

  function private.Player:Money()
    if self:UserID() == 0 then
      return 0
    else
      return player(self:UserID(), 'money')
    end
  end

  function private.Player:Team()
    if self:UserID() == 0 then
      return 0
    else
      return player(self:UserID(), 'team')
    end
  end

  function private.Player:SetTeam(team)
    if self:UserID() ~= 0 then
      if type(team) == 'string' then team = tonumber(team) end
      assert(type(team) == 'number', 'team must be number or nil')
      if team == enum_team.TEAM_TERRORIST then
        RunConsoleCommand(string.format('maket %s', self:UserID()))
      elseif team == enum_team.TEAM_COUNTER_TERRORIST then
        RunConsoleCommand(string.format('makect %s', self:UserID()))
      else
        RunConsoleCommand(string.format('makespec %s', self:UserID()))
      end
    end
  end

  function private.Player:PrintMessage(print_type, text)
    if self:UserID() ~= 0 then
      if type(print_type) == 'string' then print_type = tonumber(print_type) end
      assert(type(print_type) == 'number', 'print_type must be number or nil')
      assert(type(text) == 'string', 'text must be string or nil')
      text = string.gsub(text, '@C', '')
      if print_type == enum_print_type.HUD_PRINTCENTER then
        msg2(self:UserID(), string.format('%s@C', text))
      else
        msg2(self:UserID(), text)
      end
    end
  end

  function private.Player:ChatPrint(text)
    if self:UserID() ~= 0 then
      assert(type(text) == 'string', 'text must be string or nil')
      msg2(self:UserID(), string.gsub(text, '@C', ''))
    end
  end

  function private.Player:Hud(index, text, pos, align)
    if self:UserID() ~= 0 then
      if type(index) == 'string' then index = tonumber(index) end
      if type(align) == 'string' then align = tonumber(align) end
      assert(type(index) == 'number', 'index must be number or nil')
      assert(type(text) == 'string', 'text must be string or nil')
      assert(type(pos) == 'table', 'pos must be table or nil')
      assert(type(align) == 'number', 'align must be number or nil')
      RunConsoleCommand(string.format('hudtxt2 %s %s %s %s %s %s', self:UserID(), index, text, pos.x, pos.y, align))
    end
  end

  function private.Player:ClearHud(index)
    if self:UserID() ~= 0 then
      if type(index) == 'string' then index = tonumber(index) end
      assert(type(index) == 'number', 'index must be number or nil')
      RunConsoleCommand(string.format('hudtxt2 %s %s %s %s %s %s', self:UserID(), index, '', 0, 0, enum_text_align.TEXT_ALIGN_LEFT))
    end
  end

  function private.Player:IsBot()
    if self:UserID() == 0 then
      return 1
    else
      return util.tobool(player(self:UserID(), 'bot'))
    end
  end

  function private.Player:IsPlayer()
    return not self:IsBot()
  end

  function private.Player:IsListenServerHost()
    if self:IPAddress() == '0.0.0.0' then return true end
    if self:IPAddress() == '127.0.0.1' then return true end
    if string.find(self:IPAddress(), '10.0.0.[^*]') ~= nil then return true end
    if string.find(self:IPAddress(), '192.168.[^*].[^*]') ~= nil then return true end
    return false
  end

  function private.Player:GetActiveWeapon()
    if self:Alive() then
      return weapon.GetByType(player(self:UserID(), 'weapontype'))
    else
      return nil
    end
  end

  function private.Player:GetWeapons()
    local Table = {}
    if self:Alive() then
      for _, v in pairs(playerweapons(self:UserID())) do
        table.insert(Table, weapon.GetByType(v))
      end
    end
    return Table
  end

  function private.Player:CloseItems(ranger)
    local Table = {}

    if self:Alive() then
      if type(ranger) == 'string' then ranger = tonumber(ranger) end
      assert(type(ranger) == 'number', 'ranger must be number or nil')
      if ranger == 0 then ranger = 1 end
      for _, v in pairs(closeitems(self:UserID(), ranger)) do
        table.insert(Table, item.GetByID(v))
      end
      return Table
    end

    return Table
  end

  function private.Player:IsIdle()
    if self:UserID() == 0 then
      return 0
    else
      return player(self:UserID(), 'idle')
    end
  end

  function private.Player:Angle()
    if self:UserID() == 0 then
      return 0
    else
      return player(self:UserID(), 'rot')
    end
  end

  function private.Player:HasNightvision()
    if self:UserID() == 0 then
      return 0
    else
      return player(self:UserID(), 'nightvision')
    end
  end

  function private.Player:HasDefusekit()
    if self:UserID() == 0 then
      return 0
    else
      return player(self:UserID(), 'defusekit')
    end
  end

  function private.Player:HasBomb()
    if self:UserID() == 0 then
      return 0
    else
      return player(self:UserID(), 'bomb')
    end
  end

  function private.Player:HasFlag()
    if self:UserID() == 0 then
      return 0
    else
      return player(self:UserID(), 'flag')
    end
  end

  function private.Player:HasWeapon(index)
    if self:Alive() then
      if type(index) == 'string' then index = tonumber(index) end
      assert(type(index) == 'number', 'index must be number or nil')
      for k, v in pairs(self:GetWeapons()) do
        if index == v:Type() then
          return true
        end
      end
    end

    return false
  end

  function private.Player:StripWeapon(index)
    if self:Alive() then
      if index == nil then index = self:GetActiveWeapon():Type() end
      if type(index) == 'string' then index = tonumber(index) end
      assert(type(index) == 'number', 'index must be number or nil')
      if self:HasWeapon(index) then
        RunConsoleCommand(string.format('strip %s %s', self:UserID(), index))
      end
    end
  end

  function private.Player:StripWeapons()
    if self:Alive() then
      for k, v in pairs(self:GetWeapons()) do
        self:StripWeapon(v:Type())
      end
    end
  end

  function private.Player:DropWeapon(index)
    if self:Alive() then
      if index == nil then index = self:GetActiveWeapon():Type() end
      if type(index) == 'string' then index = tonumber(index) end
      assert(type(index) == 'number', 'index must be number or nil')
      if self:HasWeapon(index) then
        self:StripWeapon(index)
        RunConsoleCommand(string.format('spawnitem %s %s %s', self:UserID(), self:Tile().x, self:Tile().y))
      end
    end
  end

  function private.Player:SelectWeapon(index)
    if self:Alive() then
      if type(index) == 'string' then index = tonumber(index) end
      assert(type(index) == 'number', 'index must be number or nil')
      if self:HasWeapon(index) then
        RunConsoleCommand(string.format('setweapon %s %s', self:UserID(), index))
      end
    end
  end

  function private.Player:Give(index)
    if self:Alive() then
      if type(index) == 'string' then index = tonumber(index) end
      assert(type(index) == 'number', 'index must be number or nil')
      if not self:HasWeapon(index) and ext_weapon.Exists(index) then
        RunConsoleCommand(string.format('equip %s %s', self:UserID(), index))
        self:SelectWeapon(index)
      end
    end
  end

  function private.Player:Look()
    if self:UserID() == 0 then
      return 0
    else
      return player(self:UserID(), 'look')
    end
  end
end

return pif