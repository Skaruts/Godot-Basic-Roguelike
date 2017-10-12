extends Node2D

#var pre_ui = preload("res://scenes/UI.tscn")
#var pre_mapview = preload("res://scenes/MapView.tscn")

var world
var map_view
var ui

func _ready():
	# just a file where I can test little things and print stuff in one place
#	var test = load("res://scripts/GDScript_Tests.gd").new()
#	add_child( test )

	set_screen_size()
	create_ui()
	set_process_input(true)

func create_ui():
	ui = get_node("UI")
	map_view = get_node("MapView")

#	ui = pre_ui.instance()
#	map_view = pre_mapview.instance()

#	add_child(ui)
#	add_child(map_view)

	ui.reposition()
	map_view.reposition()

	world = global.world

func set_screen_size():
	var TW = textures.get_tile_width()
	var TH = textures.get_tile_height()
	var GW = settings.GRID_WIDTH
	var GH = settings.GRID_HEIGHT
	var screen_width =  OS.get_screen_size().x
	var screen_height = OS.get_screen_size().y
	var window_width = GW*TW
	var window_height = GH*TH

	OS.set_window_size( Vector2(window_width, window_height) )
	OS.set_window_position( Vector2( screen_width/2 - window_width/2, screen_height/2 - window_height/2 ) )
#	print("WS: ", OS.get_window_size(), "  |  TW, TH: ", TW, ", ", TH, "  |  SS: ", OS.get_screen_size())

func _input(event):
	if event.is_action_pressed("k_quit"):               exit()

	if event.is_action_pressed("k_switch_tex_up"):      switch_texture(-1)
	if event.is_action_pressed("k_switch_tex_down"):    switch_texture(1)
	if event.is_action_pressed("k_rebuild_map"):        world.rebuild_map()

	if event.is_action_pressed("k_debug"):              world.toggle_debug()
	if event.is_action_pressed("k_health"):             world.toggle_debug_hp()
	if event.is_action_pressed("k_leaves"):             world.toggle_debug_leaves()
	if event.is_action_pressed("k_rooms"):              world.toggle_debug_rooms()
	if event.is_action_pressed("k_halls"):              world.toggle_debug_halls()
	if event.is_action_pressed("k_room_info"):          world.toggle_debug_room_info()

func switch_texture(dir):
	if textures.switch_texture(dir):
		# 0 default | 1 reverse | 2 real Time | 4 unique
		get_tree().call_group(2, "CELLS", "switch_texture")
		ui.reposition()
		map_view.reposition()
		set_screen_size()

func exit():
	get_tree().quit()
