class_name MachineType
extends Node2D

#Signals
signal machine_action_needed
signal machine_broken


# Machine Stat Enumeration
enum MACHINE_STATE {
	RUNNING,
	BROKEN
}

# Machine Type
enum MACHINE_NAME {
	NUCLEAR_CORE
}


# Property Name: action_name
# Description:
# 	What the action will be refered to in other scripts
# 	Will remove any spaces within the string
@export var machine_name: MACHINE_NAME:
	set(value):
		machine_name = value
	get:
		return machine_name
	

# Property Name: action_time
# Description:
#	The time it will take to complete the action in (seconds) 
#	min is 0.1 max is 15
@export_range(0.1, 15) var action_time: float = 1:
	set(value):
		action_time = clamp(value, 0.1, 15)
	get:
		return action_time


# Property Name: repair_time
# Description:
#	The time it will to complete a repair of the item
@export_range(10, 25) var repair_time: float = 10:
	set(value):
		repair_time = clamp(value, 10, 25)
	get:
		return repair_time


# Property Name: event_time
# Description:
#	The time it will take to check for an event to see if the machine will break
@export_range(30, 45) var event_time: int = 30:
	set(value):
		event_time = clamp(value, 30, 45)
	get:
		return event_time


# Property Name: current_machine_state
# Description:
# 	Holds the state of the current machine whether RUNNING, ACTION_NEEDED,
# 	or BROKEN
@export var current_machine_state: MACHINE_STATE = MACHINE_STATE.RUNNING:
	set(value):
		current_machine_state = value
	get:
		return current_machine_state


# Timer references
@export var action_time_timer: Timer
@export var repair_time_timer: Timer
@export var weighted_event_timer: Timer



# Function Name: _ready
# Description:
# 	Initialize the timers wait time and connect their timeout signals to 
#	function within this script
func _ready():
	action_time_timer.wait_time = action_time
	action_time_timer.timeout.connect(_on_action_time_timer_timeout)
	repair_time_timer.wait_time = repair_time
	repair_time_timer.timeout.connect(_on_repair_time_timer_timeout)
	weighted_event_timer.wait_time = event_time
	weighted_event_timer.timeout.connect(_on_weighted_event_timer_timeout)
	weighted_event_timer.start()
	print(weighted_event_timer.is_stopped())



# Function Name: _on_action_time_timer_timeout
# Description:
# 	Emit that the nuclear core action is stopped
func _on_action_time_timer_timeout():
	GlobalSignalGlue.nuclear_core_action_stopped.emit()



# Function Name: _on_repair_time_timer_timeout
# Description:
#	Reset the machine when the repair is completed
func _on_repair_time_timer_timeout():
	machine_reset()
	repair_time_timer.stop()



# Function Name: _on_weighted_event_timer_timeout
# Description:
# 	When the timer timesout calculate break event to see if the machine breaks, only 
# 	calculate it when the machine is not broken
func _on_weighted_event_timer_timeout():
	if current_machine_state != MACHINE_STATE.BROKEN:
		calculate_weighted_break_event()


# Function Name: start_machine_action
# Description:
# 	
func start_machine_action(m_name: MACHINE_NAME) -> void:
	action_time_timer.start()
	
	if m_name == MACHINE_NAME.NUCLEAR_CORE:
		GlobalSignalGlue.nuclear_core_action_started.emit()



# Function Name: generate_random_event_number
# Description:
# 	Will create and return a random integer between 1 and 100
func generate_random_event_number() -> float:
	var rand_gen: RandomNumberGenerator = RandomNumberGenerator.new()
	rand_gen.randomize()
	return rand_gen.randi_range(1, 100)



# Function Name: calculate_weighted_break_event
# Description: 
# 	Will decide to change the state of the Machine based on if this, then emit
#	the machine_broken signal
func calculate_weighted_break_event() -> void:
	var weighted_number: float = generate_random_event_number()
	if weighted_number > 0 && weighted_number <= 10:
		current_machine_state = MACHINE_STATE.BROKEN
		machine_broken.emit()



# Function Name: machine_reset
# Description:
# 	Will reset the machine to running when it is fixed
func machine_reset() -> void:
	if current_machine_state == MACHINE_STATE.BROKEN:
		current_machine_state = MACHINE_STATE.RUNNING
