extends Node2D

var parent
var pos = Vector2()		# local position in tiles
var g_pos = Vector2()	# global position in tiles
var w = 1
var h = 1
var fg
var bg

func _ready():
	add_to_group("UI_ELEMENTS")

func set_position(p):
	var TS = textures.get_tile_sizes()
	pos = p
	set_pos( pos * TS )
	g_pos = get_global_pos() / TS

func set_size(w, h):
	self.w = w
	self.h = h

func set_fg(fg):    self.fg = fg
func set_bg(bg):    self.bg = bg

func start_processing():	set_process_input(true)
func stop_processing():		set_process_input(false)

func check_mouse():
	var m_pos = global.mouse_grid
	return m_pos.x >= g_pos.x and m_pos.x < g_pos.x+w and m_pos.y >= g_pos.y and m_pos.y < g_pos.y+h