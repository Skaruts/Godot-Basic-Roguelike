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
		global.callf("log_line", "%s attacks %s for ^0%d^ HP" % [parent.name, target.name, damage] )
		target.combat.take_damage(damage)
	else:
		global.callf("log_line", "%s attacks %s but does no damage." % [parent.name, target.name] )

func take_damage(damage):

	if damage > 0:
		hp = clamp(hp - damage, 0, hp)
		parent.set_label_text( str(hp) )

		if hp <= 0:
			parent.die( )

