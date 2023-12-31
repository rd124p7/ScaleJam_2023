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



# Function Name: 
# Description:
# 	Get the machine type that the player collided with and then start the action for that machine
func start_nuclear_action(machine_to_start_action: Node2D) -> void:
	if get_parent().monkey_action_state == MonkeyState.M_STATES.DO_ACTION:
		get_machine_type(machine_to_start_action).start_machine_action(
			get_machine_type(machine_to_start_action).machine_name
		)



# Function Name: get_machine_type
# Description:
# 	Get the machine type from the collider
func get_machine_type(m_base: Node2D) -> Node2D:
	for machine in m_base.get_children():
		if machine.name == "MachineType":
			return machine
	return
