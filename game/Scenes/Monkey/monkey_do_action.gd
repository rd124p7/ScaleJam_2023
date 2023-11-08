extends Node2D




# Function Name: _ready
# Description:
# 	Connect the action signals
func _ready():
	GlobalSignalGlue.nuclear_core_clicked.connect(_on_nuclear_core_clicked)
	GlobalSignalGlue.nuclear_core_action_stopped.connect(_on_nuclear_core_action_stopped)


# Function Name: _on_nuclear_core_clicked
# Description:
#	When the nuclear core is clicked, change monkey state from IDLE to DO_ACTION, set the target position for pathfinding
#	and emit the action_has_been_selected to tell the camera the new focus position
func _on_nuclear_core_clicked(core_position: Vector2):
	if get_parent().monkey_action_state == MonkeyState.M_STATES.IDLE:
		get_parent().monkey_action_state = MonkeyState.M_STATES.DO_ACTION
		get_parent().target_action_position = core_position
		get_parent().action_has_been_selected.emit(core_position)



# Function Name: _on_nuclear_core_action_stopped
# Description:
# 	When the action is completed change the monkey state back to IDLE
func _on_nuclear_core_action_stopped():
	if get_parent().monkey_action_state == MonkeyState.M_STATES.DO_ACTION:
		get_parent().monkey_action_state = MonkeyState.M_STATES.RETURN_STATION
		print("Start")




# Function Name: 
# Description:
# 	
func start_nuclear_action(machine_to_start_action: Node) -> void:
	if get_parent().monkey_action_state == MonkeyState.M_STATES.DO_ACTION:
		machine_to_start_action.get_node("MachineType").start_machine_action(
			machine_to_start_action.get("MachineType").machine_name
		)

func test_func():
	print("Hello")