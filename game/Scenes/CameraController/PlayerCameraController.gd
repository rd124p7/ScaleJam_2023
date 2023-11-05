extends Node2D


# Signal to highlight the possible actions
signal highlight_possible_actions
signal camera_zoomed_out
signal camera_zoomed_in

var is_zoomed_out: bool = false

# Camera Smoothing Speed Variables
const CAM_SMOOTH_ZOOM_IN: float = 1.5
const CAM_SMOOTH_ZOOM_OUT: float = 5.5


# Function Name: _process
# Description:
# 	Call the move_camera_with_mouse function
func _process(_delta):
	move_camera_with_mouse()



# Function Name: _on_monkey_action_needs_selecting
# Description:
#	Smoothly zoom the camera out and emit the highlight_possible_actions signal
func _on_monkey_action_needs_selecting():
	is_zoomed_out = true
	var camera_zoom_tween = create_tween().set_trans(Tween.TRANS_SINE)
	camera_zoom_tween.tween_property($PlayerCamera, "zoom", Vector2(0.5, 0.5), 1)
	camera_zoom_tween.finished.connect(_on_camera_zoom_tween_finished)
	camera_zoomed_out.emit()



# Function Name: _on_monkey_action_has_been_selected
# Description:
#	Smoothly zoom the camera back in and focus on the selected action target 	
func _on_monkey_action_has_been_selected(target_camera_position):
	is_zoomed_out = false
	var camera_zoom_tween = create_tween().set_trans(Tween.TRANS_SINE)
	camera_zoom_tween.tween_property($PlayerCamera, "zoom", Vector2(1, 1), 1)
	$PlayerCamera.position = $PlayerCamera.position.lerp(target_camera_position, 0.2)
	camera_zoomed_in.emit()



# Function Name: _on_camera_zoom_tween_finished
# Description:
#	Emit the highlight_possible_actions to tell the action nodes to highlight
func _on_camera_zoom_tween_finished():
	#highlight_possible_actions.emit()
	GlobalSignalGlue.animate_select_nuclear_core.emit()


# Function Name: move_camera_with_mouse
# Description:
# 	When not zoomed out, follow the mouse position, position smoothing is 
#	enabled in the cameras settings
func move_camera_with_mouse():
	if !is_zoomed_out:
		if $PlayerCamera.position_smoothing_speed != CAM_SMOOTH_ZOOM_IN:
			$PlayerCamera.position_smoothing_speed = CAM_SMOOTH_ZOOM_IN

		var mouse_position = get_local_mouse_position()
		$PlayerCamera.position = $PlayerCamera.position.lerp(mouse_position, 0.7)
	else:
		$PlayerCamera.position_smoothing_speed = CAM_SMOOTH_ZOOM_OUT