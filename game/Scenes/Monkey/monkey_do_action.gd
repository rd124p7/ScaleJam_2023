extends Node2D

# Function Name: _ready
# Description:
# 	Connect the action signals
func _ready():
	GlobalSignalGlue.nuclear_core_clicked.connect(_on_nuclear_core_clicked)



# Function Name: _on_nuclear_core_clicked
# Description:
#	When the nuclear core is clicked, change monkey state from IDLE to DO_ACTION, set the target position for pathfinding
#	and emit the action_has_been_selected to tell the camera the new focus position
func _on_nuclear_core_clicked(core_position: Vector2):
	if get_parent().monkey_action_state == MonkeyState.M_STATES.IDLE:
		get_parent().monkey_action_state = MonkeyState.M_STATES.DO_ACTION
		get_parent().target_action_position = core_position
		get_parent().action_has_been_selected.emit(core_position)
	print(core_position)
