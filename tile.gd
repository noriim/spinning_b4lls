extends ColorRect

var mouse_in = false
#signal change_color()

func _input(event):
	if event.is_action_pressed("click"):
		if mouse_in:
			if get_child_count() > 0:
				print("already a ball here") # temporary check
			else:
				var ball = preload("res://ball.tscn").instantiate()
				ball.position = size / 2
				add_child(ball)
				get_parent()._on_tile_change_color()
				get_child(0).get_child(1).visible = get_parent().color_picker
				#change_color.emit()

func _on_mouse_entered():
	mouse_in = true
	
func _on_mouse_exited():
	mouse_in = false
