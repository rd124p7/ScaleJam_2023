extends Node2D


# Signal to highlight the possible actions
signal highlight_possible_actions


var is_zoomed_out: bool = false

# Camera Smoothing Speed Variables
const CAM_SMOOTH_ZOOM_IN: float = 1.5
const CAM_SMOOTH_ZOOM_OUT: float = 5.5


func _ready():
	pass


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



# Function Name: _on_camera_zoom_tween_finished
# Description:
#	Emit the highlight_possible_actions to tell the action nodes to highlight
func _on_camera_zoom_tween_finished():
	print("Start to Scale")
	highlight_possible_actions.emit()



# Function Name: move_camera_with_mouse
# Description:
# 	When not zoomed out, follow the mouse position, position smoothing is 
#	enabled in the cameras settings
func move_camera_with_mouse():
	if !is_zoomed_out:
		if $PlayerCamera.position_smoothing_speed != CAM_SMOOTH_ZOOM_IN:
			$PlayerCamera.position_smoothing_speed = CAM_SMOOTH_ZOOM_IN

		var mouse_position = get_local_mouse_position()
		$PlayerCamera.position = lerp(mouse_position, mouse_position, 0.1)
	else:
		$PlayerCamera.position_smoothing_speed = CAM_SMOOTH_ZOOM_OUT
