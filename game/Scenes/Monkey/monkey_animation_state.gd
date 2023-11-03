class_name MonkeyAnimationState
extends Node

signal animation_state_changed

enum M_ANIMATION_STATE {
	
}


var current_animation_state: M_ANIMATION_STATE:
	set(value):
		current_animation_state = value
		animation_state_changed.emit()
	get:
		return current_animation_state
