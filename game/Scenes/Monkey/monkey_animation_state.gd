class_name MonkeyAnimationState
extends Node

signal animation_state_changed

# Animation state constants
enum M_ANIMATION_STATE {
	
}



# Property Name: current_animation_state
# Description:
#	Holds the current M_ANIMATION_STATE constant, 
#	will emit animation_state_changed when a new value is set
var current_animation_state: M_ANIMATION_STATE:
	set(value):
		current_animation_state = value
		animation_state_changed.emit()
	get:
		return current_animation_state
