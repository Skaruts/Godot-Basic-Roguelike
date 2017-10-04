extends Node2D

var world
var map_view
var side_panel
var ui_frame

var ui_left = false # else it's on the right

func _ready():
	set_process_input(true)

	map_view = get_node("Map View")
	side_panel = get_node("Side Panel")
	ui_frame = get_node("UI Frame")
	set_screen_size()
	position_ui()

	world = get_tree().get_root().get_node("main/Map View/Viewport/World")


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

	print("WS: ", OS.get_window_size(), "  |  TS: ", TS, "  |  SS: ", OS.get_screen_size())
	print()

func position_ui():
	var TS = textures.get_tile_size()
	if ui_left:
		map_view.set_pos( Vector2(31*TS, 1*TS) )
		# side_panel.set_global_pos( Vector2(1*TS, 1*TS) )
	else:
		map_view.set_pos( Vector2(1*TS, 1*TS) )
		# side_panel.set_pos( Vector2(50*TS, 1*TS) )
	map_view.get_node("Viewport").set_rect( Rect2(Vector2(), Vector2(48*TS, 48*TS)) )

func _input(event):
	if event.is_action_pressed("k_quit"):
		exit()

	if event.is_action_pressed("k_switch_tex_up"):
		switch_texture(-1)
	if event.is_action_pressed("k_switch_tex_down"):
		switch_texture(1)

	if event.is_action_pressed("k_debug"):			world.toggle_debug()
	if event.is_action_pressed("k_rebuild_map"):	world.rebuild_map()
	if event.is_action_pressed("k_health"):			world.toggle_debug_hp()
	if event.is_action_pressed("k_leaves"):			world.toggle_debug_leaves()
	if event.is_action_pressed("k_rooms"):			world.toggle_debug_rooms()
	if event.is_action_pressed("k_halls"):			world.toggle_debug_halls()
	if event.is_action_pressed("k_room_info"):		world.toggle_debug_room_info()

func switch_texture(dir):
	textures.switch_texture(dir)
	world.switch_texture()
	ui_frame.switch_texture()
	set_screen_size()
	position_ui()


func exit():
	get_tree().quit()
