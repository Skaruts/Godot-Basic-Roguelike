#######################################################################
# Combat component
# Handles combat mechanics
#######################################################################
extends Node

var hp        = 100
var mana      = 100
var max_mana  = 100
var max_hp    = 100
var strength  = 0
var defense   = 0
var parent    = null

func _ready():
	parent = get_parent()
	parent.set_label_text( str(hp) )

func attack(target):
	var damage = strength - target.combat.defense
	if damage > 0:
		global.callf("log_line", parent.name + ' attacks ' + target.name + ' for ' + str(damage) + ' HP')
		target.combat.take_damage(damage)
	else:
		global.callf("log_line", parent.name + ' attacks ' + target.name + ' but does no damage')

func take_damage(damage):

	if damage > 0:
		hp = clamp(hp - damage, 0, hp)
		parent.set_label_text( str(hp) )

		if hp <= 0:
			parent.die( )

