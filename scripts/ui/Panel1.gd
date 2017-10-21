extends "res://scripts/widgets/UI_Panel.gd"

var pre_label = preload("res://scripts/widgets/UI_Label.gd")
var pre_counter = preload("res://scripts/widgets/UI_Counter.gd")

var BAR_WIDTH = 20

var hp_label
var mana_label

var health_bar
var mana_bar
var attack
var attack_count
var defense
var defense_count

func _ready():
	attack  = pre_label.new( Vector2(2, 2), 10, "Attack" , 'left')
	defense = pre_label.new( Vector2(2, 3), 10, "Defense" , 'left')
	add_widget( attack )
	add_widget( defense )

	attack_count  = pre_counter.new( Vector2(9, 2), 2, 10, false, true, 'right' )
	defense_count = pre_counter.new( Vector2(9, 3), 2, 10, false, true, 'right' )
	add_widget( attack_count )
	add_widget( defense_count )

	hp_label   = pre_label.new( Vector2(1, 9), 10, "HP" )
	mana_label = pre_label.new( Vector2(1, 11), 10, "Mana" )
	add_widget( hp_label )
	add_widget( mana_label )

	health_bar = load("res://scripts/widgets/UI_Bar.gd").new( Vector2(1, 10), BAR_WIDTH, charcodes.HP_BAR, colors.RED3, colors.RED1 )
	mana_bar   = load("res://scripts/widgets/UI_Bar.gd").new( Vector2(1, 12), BAR_WIDTH, charcodes.HP_BAR, colors.BLUE3, colors.BLUE1 )
	add_widget( health_bar )
	add_widget( mana_bar )

	set_process(true)


func _process(delta):
	if global.took_turn:
		attack_count.set_value( global.player.combat.strength )
		defense_count.set_value( global.player.combat.defense )
		health_bar.set_value( global.player.combat.hp, global.player.combat.max_hp )
		mana_bar.set_value( global.player.combat.mana, global.player.combat.max_mana )
	pass