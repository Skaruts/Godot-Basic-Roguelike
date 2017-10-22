#######################################################
# Text specific half tile, that uses narrow fonts
#######################################################
extends "res://scripts/factories/Cell.gd"

func resize_bg():
	var FW = textures.get_font_width()
	var FH = textures.get_font_height()
	background.set_polygon( Vector2Array( [Vector2(0, 0), Vector2(FW, 0), Vector2(FW, FH), Vector2(0, FH)] ) )

func set_position(p):
	var FW = textures.get_font_width()
	var FH = textures.get_font_height()
	pos = p
	set_pos( Vector2(pos.x*FW, pos.y*FH) )

func switch_font():
	set_texture( textures.get_font() )
	set_position(pos)
	resize_bg()
