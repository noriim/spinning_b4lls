extends ColorRect

var mouse_in = false

func _input(event):
	if event.is_action_pressed("click"):
		if mouse_in:
			if get_child_count() > 0:
				print("already a ball here") # temporary check
			else:
				var ball = preload("res://ball.tscn").instantiate()
				ball.position = size / 2
				add_child(ball)

func _on_mouse_entered():
	mouse_in = true
	
func _on_mouse_exited():
	mouse_in = false
