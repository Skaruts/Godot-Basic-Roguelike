extends Node2D

var pre_ui = preload("res://scripts/UI.gd")

var world
var map_view
var ui

# var ui_frame

func _ready():
	# just a file where I can test little things
	#var test = load("res://scripts/GDScript_Tests.gd").new()
	#add_child( test )

	set_screen_size()
	create_ui()
	set_process_input(true)

func create_ui():
	world = get_tree().get_root().get_node("main/Map View/Viewport/World")
	ui = pre_ui.new()
	ui.init(world)
	add_child(ui)

	map_view = get_node("Map View")
	map_view.set_size(34, 34)
	if settings.INVERT_UI == 0:		map_view.set_position( Vector2(12, 0) )
	else:							map_view.set_position( Vector2(18, 0) )
	map_view.set_size(34, 34)

func set_screen_size():
	var TS = textures.get_tile_size()
	var GW = settings.GRID_WIDTH
	var GH = settings.GRID_HEIGHT
	var screen_width =  OS.get_screen_size().x
	var screen_height = OS.get_screen_size().y
	var window_width = GW*TS
	var window_height = GH*TS

	# TODO: if window is maximized, let it stay maximized

	OS.set_window_size( Vector2(window_width, window_height) )
	OS.set_window_position( Vector2( screen_width/2 - window_width/2, screen_height/2 - window_height/2 ) )
	# print("WS: ", OS.get_window_size(), "  |  TS: ", TS, "  |  SS: ", OS.get_screen_size())

func _input(event):
	if event.is_action_pressed("k_quit"):				exit()

	if event.is_action_pressed("k_switch_tex_up"):		switch_texture(-1)
	if event.is_action_pressed("k_switch_tex_down"):	switch_texture(1)
	if event.is_action_pressed("k_rebuild_map"):		world.rebuild_map()

	if event.is_action_pressed("k_debug"):				world.toggle_debug()
	if event.is_action_pressed("k_health"):				world.toggle_debug_hp()
	if event.is_action_pressed("k_leaves"):				world.toggle_debug_leaves()
	if event.is_action_pressed("k_rooms"):				world.toggle_debug_rooms()
	if event.is_action_pressed("k_halls"):				world.toggle_debug_halls()
	if event.is_action_pressed("k_room_info"):			world.toggle_debug_room_info()

func switch_texture(dir):
	textures.switch_texture(dir)
	for t in get_tree().get_nodes_in_group("CELLS"):
		t.switch_texture()

	set_screen_size()
	ui.reposition()

	if settings.INVERT_UI == 0:		map_view.set_position( Vector2(12, 0) )
	else:							map_view.set_position( Vector2(18, 0) )
	map_view.set_size(34, 34)


func exit():
	get_tree().quit()
