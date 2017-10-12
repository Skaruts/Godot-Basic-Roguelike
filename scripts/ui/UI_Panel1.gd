extends "res://scripts/ui/UI_Panel.gd"

var pre_label = preload("res://scripts/ui/UI_Label.gd")
var BAR_WIDTH = 10

var hp_label
var mana_label

var health_bar
var mana_bar
var attack
var attack_count
var defense
var defense_count

func _ready():
	attack         = pre_label.new()
	defense        = pre_label.new()
	attack.init( Vector2(5, 2), "Attack", colors.GRAY4, colors.BLACK )
	defense.init( Vector2(4, 3), "Defense", colors.GRAY4, colors.BLACK )
	add_child( attack )
	add_child( defense )

	attack_count   = pre_label.new()
	defense_count  = pre_label.new()
	attack_count.init(  Vector2(1, 2), "10", colors.GRAY3, colors.BLACK )
	defense_count.init( Vector2(1, 3), "10", colors.GRAY3, colors.BLACK )
	add_child( attack_count )
	add_child( defense_count )



	hp_label   = pre_label.new()
	mana_label = pre_label.new()
	hp_label.init(   Vector2(1, 9), "HP", colors.GRAY4, colors.BLACK   )
	mana_label.init( Vector2(1, 11), "Mana", colors.GRAY4, colors.BLACK )
	health_bar = load("res://scripts/ui/UI_HealthBar.gd").new( Vector2(1, 10), BAR_WIDTH )
	mana_bar   = load("res://scripts/ui/UI_ManaBar.gd").new(   Vector2(1, 12), BAR_WIDTH )
	add_child( health_bar )
	add_child( hp_label )
	add_child( mana_bar )
	add_child( mana_label )

	set_process(true)


func _process(delta):
	if global.took_turn:
		attack_count.set_text( str(global.player.combat.strength) )
		defense_count.set_text( str(global.player.combat.defense) )
		health_bar.set_hp(global.player.combat.hp, global.player.combat.max_hp)
		mana_bar.set_mana(global.player.combat.mana, global.player.combat.max_mana)
	pass