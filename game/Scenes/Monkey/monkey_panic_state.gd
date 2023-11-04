class_name MonkeyPanicState
extends Node

signal panic_state_changed

# Panic states, used for animation
enum M_PANIC_STATE {
	CALM,
	AGGITATED,
	PANIC
}



# Property Name: current_panic_state
# Description:
#	Current panic state that is used to determine the animation of the monkey
var current_panic_state: M_PANIC_STATE = M_PANIC_STATE.CALM:
	set(value):
		current_panic_state = value
	get:
		return current_panic_state



# Property Name: current_panic_percentage
# Description:
# 	Current panic percentage between 0, 1, used to for game logic instead of animation, then
#   call the convert_percentage_into_animated_state function to change the current_panic_state
var current_panic_percentage: float = 0:
	set(value):
		current_panic_percentage = clamp(value, 0, 1)
		convert_percentage_into_animated_state()
	get:
		return current_panic_percentage



# Function Name: convert_percentage_into_animated_state
# Description:
# 	Will change the current_panic_state variable based on the current_panic_percentage value,
#	Since there are 3 panic states the current_panic_state value will change every 0.3 of the percentage
func convert_percentage_into_animated_state() -> void:
	if current_panic_state > 0 && current_panic_percentage < 0.4:
		# Only set the state once
		if current_panic_state != M_PANIC_STATE.CALM:
			current_panic_state = M_PANIC_STATE.CALM
	
	if current_panic_percentage > 0.4 && current_panic_percentage < 0.7:
		# Only set the state once
		if current_panic_state != M_PANIC_STATE.AGGITATED:
			current_panic_state = M_PANIC_STATE.AGGITATED

	if current_panic_percentage > 0.7 && current_panic_percentage < 1.0:
		# Only set the state once
		if current_panic_state != M_PANIC_STATE.PANIC:
			current_panic_state = M_PANIC_STATE.PANIC
