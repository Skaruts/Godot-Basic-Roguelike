extends "res://scripts/widgets/UI_Panel.gd"

var pre_label = preload("res://scripts/widgets/UI_Label.gd")

var texts = []
var labels = []
var max_lines
func _ready():
	global.addf(self, "log_line")
	max_lines = h-2

func log_line(line):
	texts.push_back(line)

	var l = pre_label.new( Vector2(1, labels.size()+1), 10, line )
	labels.append(l)
	add_child(l)

	if labels.size() > max_lines:
		remove_child(labels[0])
		labels.pop_front()
		for l in labels:
			l.set_position(Vector2(l.pos.x, l.pos.y-1))
