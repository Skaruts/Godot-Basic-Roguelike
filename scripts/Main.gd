extends Node2D

var world
var map_view
var ui_panels = {}
# var ui_frame

func _ready():
	# just a file where I can test little things
	#var test = load("res://scripts/GDScript_Tests.gd").new()
	#add_child( test )

	world = get_tree().get_root().get_node("main/Map View/Viewport/World")

	set_screen_size()
	create_ui()

	set_process_input(true)

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

func create_ui():

	# put this code in a ui_main script

	map_view = get_node("Map View")
	map_view.set_size(34, 34)


	ui_panels["panel1"] = load("res://scripts/ui/UI_Panel1.gd").new()
	ui_panels["panel2"] = load("res://scripts/ui/UI_Panel2.gd").new()
	ui_panels["panel3"] = load("res://scripts/ui/UI_Panel3.gd").new()
	ui_panels["panel1"].set_size(12, settings.GRID_HEIGHT-6)
	ui_panels["panel2"].set_size(18, settings.GRID_HEIGHT)
	ui_panels["panel3"].set_size(46, 6)
	add_child( ui_panels["panel1"] )
	add_child( ui_panels["panel2"] )
	add_child( ui_panels["panel3"] )

	position_ui()

func position_ui():

	# put this code in a ui_main script

	# settings.INVERT_UI = 1
	if settings.INVERT_UI == 0:
		map_view.set_position( Vector2(12, 0) )
		ui_panels["panel1"].set_position( Vector2(0, 0) )
		ui_panels["panel2"].set_position( Vector2(46, 0) )
		ui_panels["panel3"].set_position( Vector2(0, settings.GRID_HEIGHT-6) )
	else:
		map_view.set_position( Vector2(18, 0) )
		ui_panels["panel1"].set_position( Vector2(52, 0) )
		ui_panels["panel2"].set_position( Vector2(0, 0) )
		ui_panels["panel3"].set_position( Vector2(18, settings.GRID_HEIGHT-6) )

	map_view.set_size(34, 34)	# why is this really needed?? (if not here, the view will be misplaced after switching font)


func switch_texture(dir):
	textures.switch_texture(dir)
	for t in get_tree().get_nodes_in_group("TEXTURED"):
		t.switch_texture()
	set_screen_size()
	position_ui()


func exit():
	get_tree().quit()
