#######################################################################
# Combat component
# Handles combat mechanics
#######################################################################
extends Node

var hp
var max_hp
var strength
var defense
var parent

func _ready():
	parent = get_parent()
	parent.set_label_text( str(hp) )

func attack(target):
	var damage = strength - target.combat.defense
	if damage > 0:
		callbacks.call("log_line", parent.name + ' attacks ' + target.name + ' for ' + str(damage) + ' HP.')
		target.combat.take_damage(damage)
	else:
		callbacks.call("log_line", parent.name + ' attacks ' + target.name + ' but does no damage.')

func take_damage(damage):

	if damage > 0:
		hp = clamp(hp - damage, 0, hp)
		parent.set_label_text( str(hp) )

		if hp <= 0:
			parent.die( )

