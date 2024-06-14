extends Node2D
#TODO: Make tiles visible again after their ball has been draged away
#TODO: Make tiles not visible after ball is dragged over them
var draggable = false
var is_inside_dropable = false
var body_ref
var offset: Vector2
var initialPos: Vector2

# Function to check if any sibling node is above the given node
func which_sibling_above(vector):
	# Get the parent of the node
	var siblings = get_parent().get_children()
	# Get the global position of the node
	var self_pos = vector
	print("self_pos:", self_pos)
	# Iterate through the parent's children
	for sibling in siblings:
		# Ensure we are not comparing the node with itself
		if sibling != self and sibling is ColorRect:
			var sibling_pos = sibling.global_position  + sibling.size / 2
			print("sibling_pos:", sibling_pos)
			# Check if the sibling is above the self
			if (sibling_pos.x-sibling.size.x < self_pos.x 
			and sibling_pos.x+sibling.size.x > self_pos.x 
			and sibling_pos.y-sibling.size.y < self_pos.y 
			and sibling_pos.y+sibling.size.y > self_pos.y):
				print("rect above 2")
				return sibling
	print("none above 2")
	return false

# Function to check if any sibling node is above the given node
func is_ball_above(vector):
	# Get the parent of the node
	var siblings = get_parent().get_children()
	# Get the global position of the node
	var self_pos = vector
	print("self_pos:", self_pos)
	# Iterate through the parent's children
	for sibling in siblings:
		# Ensure we are not comparing the node with itself
		if sibling != self and sibling is Node2D:
			var sibling_pos = sibling.global_position
			print("sibling_pos:", sibling_pos)
			# Check if the sibling is above the self
			if (sibling_pos.x == self_pos.x  
			and sibling_pos.y == self_pos.y ):
				print("ball above 2")
				return sibling
	print("none above 2")
	return false

func _process(delta):
	if draggable:
		if Input.is_action_just_pressed("click"):
			initialPos = global_position
			offset = get_global_mouse_position() - global_position
			global.is_dragging = true
			if which_sibling_above(self.global_position):
				which_sibling_above(self.global_position).visible = false
		if Input.is_action_pressed("click"):
			global_position = get_global_mouse_position() - offset
		elif Input.is_action_just_released("click"):
			global.is_dragging = false
			if which_sibling_above(self.global_position):
				which_sibling_above(self.global_position).visible = false
			var tween = get_tree().create_tween()
			if is_inside_dropable and not is_ball_above(body_ref.global_position):
				tween.tween_property(self, "position", body_ref.global_position, 0.2).set_ease(Tween.EASE_OUT)
				print("TEST")
				if initialPos != body_ref.global_position:
					which_sibling_above(initialPos).visible = true
			else:
				tween.tween_property(self, "global_position", initialPos, 0.2).set_ease(Tween.EASE_OUT)
				print("TEST2")
				which_sibling_above(initialPos).visible = false

func clear_behind_balls():
	if which_sibling_above(self.global_position):
					which_sibling_above(self.global_position).visible = false


func _on_area_2d_mouse_entered():
	if not global.is_dragging:
		draggable = true
		scale = Vector2(1.05, 1.05)


func _on_area_2d_mouse_exited():
	if not global.is_dragging:
		draggable = false
		scale = Vector2(1, 1)


func _on_area_2d_body_entered(body):
	if body.is_in_group('dropable'):
		is_inside_dropable = true
		body.modulate = Color(Color.REBECCA_PURPLE, 1)
		body_ref = body


func _on_area_2d_body_exited(body):
	if body.is_in_group('dropable'):
		is_inside_dropable = false
		body.modulate = Color(Color.MEDIUM_PURPLE, 0.7)
