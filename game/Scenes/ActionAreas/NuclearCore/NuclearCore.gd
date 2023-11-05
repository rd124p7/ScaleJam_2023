extends AnimatableBody2D

var has_mouse_entered: bool = false
var is_menu_action_pressed: bool = false

# Function Name: _ready
# Description: 
# 	Setup some global signals
func _ready():
	GlobalSignalGlue.animate_select_nuclear_core.connect(_on_animate_select_nuclear_core)
	GlobalSignalGlue.is_monkey_action_pressed.connect(_on_monkey_action_pressed)
	GlobalSignalGlue.is_monkey_action_not_pressed.connect(_on_monkey_action_not_pressed)



# Function Name: _process
# Description:
# 	When the mouse is in the object bounds check if the the left mouse button is 
# 	clicked
func _process(_delta):
	if has_mouse_entered && is_menu_action_pressed:
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			GlobalSignalGlue.nuclear_core_clicked.emit(position)
			print("Test Click")

			var shrink_tween = create_tween().set_trans(Tween.TRANS_ELASTIC)
			shrink_tween.tween_property($Sprite2D, "scale", Vector2(1.0, 1.0), 0.4)



# Function Name: _on_animate_select_nuclear_core
# Description:
# 	Animate the node when the camera is zoomed out 
func _on_animate_select_nuclear_core():
	var expand_tween = create_tween().set_parallel(true).set_trans(Tween.TRANS_ELASTIC)
	expand_tween.tween_property($Sprite2D, "scale", Vector2(2.0, 2.0), 0.4)



# Function Name: _on_monkey_action_pressed
# Description:
# 	Change the is_menu_action_pressed to true, Makes sure that the action button has been pressed 
#	in order to filter out the mouse click event
func _on_monkey_action_pressed():
	is_menu_action_pressed = true



# Function Name: _on_monkey_action_not_pressed
# Description:
#	Change the is_menu_action_pressed to false
func _on_monkey_action_not_pressed():
	is_menu_action_pressed = false



# Function Name: _on_mouse_entered
# Description:
# 	Set the has_mouse_enter to false aand animate change the color back to the 
#	regular asset color
func _on_mouse_entered():
	has_mouse_entered = true
	var highlight_tween = create_tween().set_trans(Tween.TRANS_SPRING)
	highlight_tween.tween_property($Sprite2D, "self_modulate", Color(1.0, 1.0, 1.0, 0.7), 0.6)



# Function Name: _on_mouse_exited
# Description:
#	Set the has_mouse_entered to true and animate change the color
func _on_mouse_exited():
	has_mouse_entered = false
	var highlight_tween = create_tween().set_trans(Tween.TRANS_SPRING)
	highlight_tween.tween_property($Sprite2D, "self_modulate", Color(0.5, 0, 0, 0.7), 0.6)



func _on_work_area_body_entered(body:Node2D):
	pass # Replace with function body.
	

func _on_work_area_body_exited(body:Node2D):
	pass # Replace with function body.
