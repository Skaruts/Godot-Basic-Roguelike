extends "res://scripts/ui/UI_Panel.gd"

var BAR_WIDTH = 10
var health_bar

func _ready():
	health_bar = load("res://scripts/ui/UI_HealthBar.gd").new( Vector2(1, 2), 10 )
	add_child( health_bar )
