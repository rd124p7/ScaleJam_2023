class_name MonkeyState
extends Node

signal monkey_state_changed

# Action state constants
enum M_STATES {
	IDLE,
	DO_ACTION,
	RETURN_STATION,
	NEED_ATTENTION,
	CALMING_DOWN
} 



# Property Name: current_state
# Description:
#	Holds the current action state of the monkey, DEFAULT = M_STATES_IDLE, 
# 	Will emit monkey_state_changed signal with the value is changed
var current_state: M_STATES = M_STATES.IDLE:
	set(value):
		current_state = value
		monkey_state_changed.emit()
	get:
		return current_state