extends Node


# Load Scripts
var monkey_action_state = preload("res://Scenes/Monkey/monkey_state.gd")
var monkey_animation_state = preload("res://Scenes/Monkey/monkey_animation_state.gd")
var monkey_panic_state = preload("res://Scenes/Monkey/monkey_panic_state.gd")

# State Machine Objects
var action_state: MonkeyState
var animation_state: MonkeyAnimationState
var panic_state: MonkeyPanicState

# Function Name: _ready
# Description:
# 	Instatiate the MonkeyState and MonkeyAnimationState classes and connect
#   their signals to the functions within this script
func _ready():
	action_state = MonkeyState.new()
	animation_state = MonkeyAnimationState.new()
	panic_state = MonkeyPanicState.new()

	action_state.name = "Monkey_State"
	action_state.monkey_state_changed.connect(_on_monkey_state_changed)

	animation_state.name = "Animation_State"
	animation_state.animation_state_changed.connect(_on_animation_state_changed)

	panic_state.name = "Panic_State"
	panic_state.panic_state_changed.connect(_on_panic_state_changed)



# Function Name: _on_monkey_state_changed
# Description:
#	When the state changes call the action_state_actions function to 
#	run a new action for the monkey
func _on_monkey_state_changed() -> void:
	action_state_actions()



# Function Name: _on_animation_state_changed
# Description:
#	When the animation state changes then call animation_state_actions 
#	to switch to the current animation
func _on_animation_state_changed() -> void:
	pass



# Function Name: _on_panic_state_changed
# Description:
# 	
func _on_panic_state_changed() -> void:
	pass



# Function Name: action_state_actions:
# Description:
# 	Check the current state and then run an action based on 
#	the current state of the action_state object
func action_state_actions() -> void:
	match action_state.current_state:
		MonkeyState.M_STATES.IDLE:
			pass
		MonkeyState.M_STATES.DO_ACTION:
			pass
		MonkeyState.M_STATES.RETURN_STATION:
			pass
		MonkeyState.M_STATES.NEED_ATTENTION:
			pass
		MonkeyState.M_STATES.CALMING_DOWN:
			pass



# Function Name: action_state_actions:
# Description:
# 	Check the current animation state, if it has changed then run the new animation
func animation_state_actions() -> void:
	pass

