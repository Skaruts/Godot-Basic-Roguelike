extends Node2D

var parent
var pos = Vector2()
var w = 1
var h = 1
var fg
var bg
func _ready():
    add_to_group("UI_ELEMENTS")

#func _init(pos=Vector2(), w=1, h=1):
#   set_position(pos)
#   set_size(w, h)

func set_position(p):
    var TS = textures.get_tile_size()
    pos = p
    set_pos( pos*TS )


func set_size(w, h):
    self.w = w
    self.h = h
