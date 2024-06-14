extends ColorRect

var mouse_in = false

# Function to check if any sibling node is above the given node
func is_any_sibling_above(node) -> bool:
	# Get the parent of the node
	var siblings = node.get_parent().get_children()
	
	# Get the global position of the node
	var node_pos = node.global_position + size/2
	print("node_pos:", node_pos)
	# Iterate through the parent's children
	for sibling in siblings:
		# Ensure we are not comparing the node with itself
		if sibling != node and sibling is Node2D:
			var sibling_pos = sibling.global_position 
			print("sibling_pos:", sibling_pos)
			# Check if the sibling is above the node
			if sibling_pos.y == node_pos.y:
				node.visible = false
				print("above")
				return true
	print("none above 1")
	node.visible = false
	return false


func _input(event):
	if event.is_action_pressed("click"):
		if mouse_in:
			if is_any_sibling_above(self):
				print("already a ball here")
			else:
				var ball = preload("res://ball.tscn").instantiate()
				ball.position = position + size / 2
				get_parent().add_child(ball)
				get_parent()._on_tile_change_color()
				ball.get_child(1).visible = get_parent().color_picker
			

func _on_mouse_entered():
	mouse_in = true
	
func _on_mouse_exited():
	mouse_in = false

	
