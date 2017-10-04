extends Node

var pre_player = preload("res://scenes/entities/Player.tscn")
var pre_mob = preload("res://scenes/entities/Mob.tscn")

# var pre_player = preload("res://scripts/entities/mobs/Player.gd")
# var pre_orc = preload("res://scripts/entities/mobs/Orc.gd")
# var pre_troll = preload("res://scripts/entities/mobs/Troll.gd")

func create_mob(pos, type, dungeon):
	var mob
	if not type in ['p', 'P', 'player']:
		mob = pre_mob.instance()
		# if type in ['o', 'O', 'orc']:		mob.set_script( pre_orc.new() )
		# elif type in ['t', 'T', 'troll']:	mob.set_script( pre_troll.new() )

		if type in ['o', 'O', 'orc']:		mob.set_script( load("res://scripts/entities/mobs/Orc.gd") )
		elif type in ['t', 'T', 'troll']:	mob.set_script( load("res://scripts/entities/mobs/Troll.gd") )
	else:
		mob = pre_player.instance()
		# mob.set_script( load("res://scripts/entities/mobs/Player.gd") )

	mob.set_dungeon(dungeon)
	mob.set_position( pos )
	return mob
