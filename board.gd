extends Node2D

var color_picker = false

func _on_tile_change_color():
	color_picker = not color_picker
	print(color_picker)
