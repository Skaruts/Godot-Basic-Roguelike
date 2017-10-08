extends "res://scripts/ui/UI_Widget.gd"

var pre_tilefactory = preload("res://scripts/TileFactory.gd")
var tilemap = []


func _ready():
    #build_frame()
    pass

func build_frame():
    var w = settings.GRID_WIDTH
    var h = settings.GRID_HEIGHT
    var TS = textures.get_tile_size()

    var tile_fac = pre_tilefactory.new(settings.GRID_WIDTH, settings.GRID_HEIGHT)
    if settings.INVERT_UI:
        tile_fac.rect(52, 0, 12, settings.GRID_HEIGHT-6)    # panel 1
        tile_fac.rect(0, 0, 18, settings.GRID_HEIGHT)   # panel 2
        tile_fac.rect(18, settings.GRID_HEIGHT-6, 46, 6)    # bottom log
    else:
        tile_fac.rect(0, 0, 12, settings.GRID_HEIGHT-6) # panel 1
        tile_fac.rect(46, 0, 18, settings.GRID_HEIGHT)  # right 2
        tile_fac.rect(0, settings.GRID_HEIGHT-6, 46, 6) # bottom log
    tilemap = tile_fac.make_tiles(self)

func clear_map():
    for t in tilemap:
        t.get_parent().remove_child(t)
        t.free()
    tilemap.clear()

