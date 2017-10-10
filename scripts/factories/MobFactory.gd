extends Node

var pre_ent = preload("res://scenes/entities/Entity.tscn")

# var pre_orc = preload("res://scripts/entities/mobs/Orc.gd")
# var pre_troll = preload("res://scripts/entities/mobs/Troll.gd")

func create_mob(pos, type, dungeon):
	var mob = pre_ent.instance()
	# if type in ['o', 'O', 'orc']:     mob.set_script( pre_orc.new() )
	# elif type in ['t', 'T', 'troll']: mob.set_script( pre_troll.new() )

	if type in ['o', 'O', 'orc']:       mob.set_script( load("res://scripts/entities/mobs/Orc.gd") )
	elif type in ['t', 'T', 'troll']:   mob.set_script( load("res://scripts/entities/mobs/Troll.gd") )

	mob.init(pos)
	mob.set_dungeon(dungeon)
	return mob
