extends "res://scripts/ui/UI_Panel.gd"

var BAR_WIDTH = 10
var health_bar

func _ready():
	set_fixed_process(true)
	#health_bar = load("res:///scripts/ui/UI_Bar.gd").new("HP", Vector2(pos.x+1, pos.y+3), 10, Color('EE0000'))
	#Bar('HP', Vector2( pos.x+1. pos.y+3 ), BAR_WIDTH, 100, player.combat.max_hp, fg, bg)

func _fixed_process(delta):
	#if get_parent().world.took_turn:
	#	var hp = get_parent().world.player.combat.hp
	#	var max_hp = get_parent().world.player.combat.max_hp
	#	#health_bar.set_value( hp, max_hp )
	pass

