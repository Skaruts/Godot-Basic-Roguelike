extends Node2D

var TS = textures.get_tile_size()
onready var label = get_node("Label")
var parent

func _ready():
	set_fixed_process(true)
	#set_label()
	label.set_pos( Vector2(1*TS, 1*TS) )


#func set_label():
	#label.set_text( "HP: " + str(get_parent().world.player.combat.hp) )

func _fixed_process(delta):
	if get_parent().world.took_turn:
		label.set_text( "HP: " + str(get_parent().world.player.combat.hp) )

# func take_turn():
# 	label.set_text( "HP: ", get_parent().world.player.combat.hp )

