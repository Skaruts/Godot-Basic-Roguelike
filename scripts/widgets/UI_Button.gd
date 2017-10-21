extends "res://scripts/widgets/UI_Widget.gd" # or maybe inherit from a Clickable.gd

# This class was just imported from another project,
# so it may need to be slightly adapted to this one

var text
var label
var callbacks = []
var args = []
var mouse_over = false
var is_clicked = false

func _init( pos, width, text, fref, arg=null ):
	set_position(pos)
	set_text(text, width)
	add_callback(fref, arg)

func _ready():
	set_process(false)
	set_process_input(false)

# need to rename this function to something else...
func init(pos, width, text, fref, arg=null):
	set_position(pos)
	set_text(text, width)
	add_callback(fref, arg)

func set_text(text, width):
	if label == null:
		label = load("res://scripts/widgets/UI_Label.gd").new( Vector2(), width, text )
		add_child(label)
	else:
		label.init( Vector2(), width, text )
	w = ceil(label.w/2)

func add_callback(fref, arg=null):
	callbacks.append(fref)
	args.append(arg)

func _process(delta):
	mouse_over = check_mouse()
	if mouse_over:
		if is_clicked:
			set_bg(colors.BUTTON_DOWN)
		else:
			set_bg(colors.BUTTON_UP)
	else:
		set_bg(colors.UI_BG)
		is_clicked = false

func _input(event):
	if mouse_over:
		if event.is_action_pressed("lmb"):
			is_clicked = true

		if event.is_action_released("lmb") and is_clicked:
			is_clicked = false
			on_hit()

func on_hit():
	is_clicked = false
	if callbacks.size():
		for i in range( callbacks.size() ):
			if args[i] != null:	callbacks[i].call_func(args[i])
			else:				callbacks[i].call_func()

func set_fg(fg):
	self.fg = fg
	label.set_fg(fg)

func set_bg(bg):
	self.bg = bg
	label.set_bg(bg)

func start_processing():
	set_process(true)
	set_process_input(true)

func stop_processing():
	set_process(false)
	set_process_input(false)

