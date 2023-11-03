extends Node


# Load Scripts
var monkey_action_state = preload("res://Scenes/Monkey/monkey_state.gd")
var monkey_animation_state = preload("res://Scenes/Monkey/monkey_animation_state.gd")

# State Machine Objects
var action_state: MonkeyState
var animation_state: MonkeyAnimationState


func _ready():
	action_state = MonkeyState.new()
	animation_state = MonkeyAnimationState.new()
	action_state.monkey_state_changed.connect(_on_monkey_state_changed)
	animation_state.animation_state_changed.connect(_on_animation_state_changed)


func _process(_delta):
	pass

func _on_monkey_state_changed() -> void:
	action_state_actions()

func _on_animation_state_changed() -> void:
	pass

# Function Name: action_state_actions:
# Description:
# 	
func action_state_actions() -> void:

	match action_state.current_state:
		MonkeyState.M_STATES.IDLE:
			pass
		MonkeyState.M_STATES.DO_ACTION:
			pass
		MonkeyState.M_STATES.COOLING_REACTOR:
			pass
		MonkeyState.M_STATES.NEED_ATTENTION:
			pass
		MonkeyState.M_STATES.CALMING_DOWN:
			pass



func animation_state_actions() -> void:
	pass