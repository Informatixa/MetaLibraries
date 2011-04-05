_entity = entity
_game = game
_item = item
_map = map
_menu = menu
_object = object
_player = player
_table = table
_tile = tile
_string = string

RunConsoleCommand = parse
MetaLibrariesVersion = 58

print("©000255000Loading MetaLibraries...")

dofile("sys/lua/libraries/enum/armor_types.lua")
dofile("sys/lua/libraries/enum/gamemodes.lua")
dofile("sys/lua/libraries/enum/hooks.lua")
dofile("sys/lua/libraries/enum/items.lua")
dofile("sys/lua/libraries/enum/object.lua")
dofile("sys/lua/libraries/enum/print_types.lua")
dofile("sys/lua/libraries/enum/supply_modes.lua")
dofile("sys/lua/libraries/enum/teams.lua")
dofile("sys/lua/libraries/enum/text_align.lua")
dofile("sys/lua/libraries/util.lua")
dofile("sys/lua/libraries/extensions/util.lua")
dofile("sys/lua/libraries/extensions/table.lua")
dofile("sys/lua/libraries/extensions/string.lua")
dofile("sys/lua/libraries/modules/hook.lua")
dofile("sys/lua/libraries/modules/command.lua")
dofile("sys/lua/libraries/modules/file.lua")
dofile("sys/lua/libraries/modules/ini.lua")
dofile("sys/lua/libraries/modules/server_settings.lua")
dofile("sys/lua/libraries/extensions/entity.lua")
dofile("sys/lua/libraries/extensions/game.lua")
dofile("sys/lua/libraries/extensions/gamemode.lua")
dofile("sys/lua/libraries/extensions/item.lua")
dofile("sys/lua/libraries/extensions/item_networked.lua")
dofile("sys/lua/libraries/extensions/map.lua")
dofile("sys/lua/libraries/extensions/object.lua")
dofile("sys/lua/libraries/extensions/player.lua")
dofile("sys/lua/libraries/extensions/menu.lua")
dofile("sys/lua/libraries/extensions/player_networked.lua")
dofile("sys/lua/libraries/extensions/player_auth.lua")
dofile("sys/lua/libraries/extensions/team.lua")
dofile("sys/lua/libraries/extensions/tile.lua")
dofile("sys/lua/libraries/extensions/weapon.lua")

print("©000255000MetaLibraries loaded!")
