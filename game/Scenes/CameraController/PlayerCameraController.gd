extends Node2D


# Signal to highlight the possible actions
signal highlight_possible_actions

func _ready():
	pass


func _process(_delta):
	pass

# Function Name: _on_monkey_action_needs_selecting
# Description:
#	Smoothly zoom the camera out and emit the highlight_possible_actions signal
func _on_monkey_action_needs_selecting():
	var camera_zoom_tween = create_tween().set_trans(Tween.TRANS_SINE)
	camera_zoom_tween.tween_property($PlayerCamera, "zoom", Vector2(0.5, 0.5), 1)

	highlight_possible_actions.emit()


