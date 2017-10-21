extends "res://scripts/widgets/UI_Bar.gd"

# THIS CLASS SEEMS REDUNDANT

func _init(pos, w).(pos, w):
	pass

func _ready():
	global.addf(self, "set_mana")
	glyph = 219

	set_fg(colors.BLUE3)
	set_bg(colors.BLUE1)

	build_bar()

func set_mana(mana, max_mana):
	set_val(mana, max_mana)
