extends "res://scripts/widgets/UI_Widget.gd"

var frame = []
var widgets = []
var mouse_over = false
var framed = true

func _ready():
	set_process(true)
	#set_process_input(true)
	pass

func _process(delta):
	if check_mouse() and not mouse_over:
		mouse_over = true
		for w in widgets:
			w.start_processing()
	elif not check_mouse() and mouse_over:
		mouse_over = false
		for w in widgets:
			w.stop_processing()

func init(x=0, y=0, w=1, h=1):
	set_position(Vector2(x, y))
	set_size(w, h)

func build_frame():
	var dt = load("res://scripts/factories/DrawTool.gd").new(w, h)
	# dt.set_colors(colors.UI_FG, colors.UI_BG)
	dt.rect(0, 0, 0, 0, true, false)
	frame = dt.get_finished(self)

func set_size(w, h):
	.set_size(w, h)
	if framed: build_frame()

func add_widget(widget):
	widgets.append(widget)
	add_child(widget)
	widget.set_owner(self)

func remove_widget(widget):
	pass

