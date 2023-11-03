class_name MonkeyState
extends Node

signal monkey_state_changed

# States Enumeration
enum M_STATES {
	IDLE,
	DO_ACTION,
	COOLING_REACTOR,
	NEED_ATTENTION,
	CALMING_DOWN
} 

# Current state of the monkey
# Will Emit a signal when the value changed
var current_state: M_STATES = M_STATES.IDLE:
	set(value):
		current_state = value
		monkey_state_changed.emit()
	get:
		return current_state