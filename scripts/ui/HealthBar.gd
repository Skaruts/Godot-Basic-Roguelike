extends "res://scripts/widgets/UI_Bar.gd"

# THIS CLASS SEEMS REDUNDANT

func _init(pos, w).(pos, w):
	pass

func _ready():
	global.addf(self, "set_hp")
	glyph = 219

	set_fg(colors.RED3)
	set_bg(colors.RED1)

	build_bar()

func set_hp(hp, max_hp):
	set_val(hp, max_hp)
