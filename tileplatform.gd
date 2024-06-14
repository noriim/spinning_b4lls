extends StaticBody2D

func _ready():
	modulate = Color(Color.MEDIUM_PURPLE, 0.7)
	
func _process(delta):
	if global.is_dragging:
		visible = true
	else:
		visible = false


var mouse_in = false

func _input(event):
	if event.is_action_pressed("click"):
		if mouse_in:
			if get_child_count() > 2:
				print("already a ball here") # temporary check
			else:
				var ball = preload("res://ball.tscn").instantiate()
				ball.position = ball.size / 2
				add_child(ball)
				get_parent()._on_tile_change_color()
				get_child(0).get_child(1).visible = get_parent().color_picker

func _on_mouse_entered():
	mouse_in = true
	
func _on_mouse_exited():
	mouse_in = false
