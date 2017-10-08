extends "res://scripts/ui/UI_Panel.gd"

var pre_label = preload("res://scripts/ui/UI_Label.gd")

var texts = []
var labels = []
var max_lines
func _ready():
	callbacks.add(self, "log_line")
	max_lines = h-2

func log_line(line):
	texts.push_back(line)

	var l = pre_label.new()
	labels.append(l)
	l.init(Vector2(1, labels.size()), line)
	add_child(l)

	if labels.size() > max_lines:
		remove_child(labels[0])
		labels.pop_front()
		for l in labels:
			l.set_position(Vector2(l.pos.x, l.pos.y-1))
