extends CharacterBody2D

# Signal to tell the camera to zoom out and highlight the possible action areas
signal action_needs_selecting
signal action_has_been_selected(target_camera_position: Vector2)

# Load Scenes
var monkey_gui_scene: PackedScene = preload("res://Scenes/Monkey/MonkeyGui/monkey_gui.tscn")


# Monkey States
var monkey_action_state: MonkeyState.M_STATES


# Monkey Gui Variables
var monkey_action_buttons: Variant
var is_monkey_selected: bool = false
var is_create_menu: bool = false

# Monkey Movement Variables
var target_action_position: Vector2 = Vector2.ZERO
var direction: Vector2 = Vector2.ZERO

func _ready():
	pass

func _process(_delta):
	handle_menu_mouse_hover() 

	# =======	TEST FUNCTION ========
	test_panic_bar()
	# =======	END TEST FUNCTION ====



# Function Name: _physics_process
# Description:
#	Move the player to the new position using pathfinding
func _physics_process(delta):
	
	if monkey_action_state == MonkeyState.M_STATES.DO_ACTION:
		$MonkeyNavigation.target_position = target_action_position
		direction = $MonkeyNavigation.get_next_path_position() - global_position
		direction = direction.normalized()
		velocity = velocity.lerp(direction * 100, 10 * delta)

	var collision_info = move_and_collide(velocity * delta)
	$MachineCollisions.check_machine_collisions(collision_info)


# Function Name: _on_mouse_entered
# Description:
# 	Change is_monkey_selected to true when the mouse 
#	has entered the monkey collision area
func _on_mouse_entered():
	is_monkey_selected = true



# Function Name: _on_mouse_exited
# 	Change is_monkey_selected to false when the mouse
#	leaves the monkey collision area
func _on_mouse_exited():
	is_monkey_selected = false
	


# Function Name: _on_action_button_activated
# Description: 
# 	When the Action Button is Pressed emit the action_needs_selecting signal, it will be used to tell 
#	the camera to zoom out and highlight the action areas, then destroy the menu when the action button is clicked
func _on_action_button_activated():
	action_needs_selecting.emit()
	GlobalSignalGlue.is_monkey_action_pressed.emit()



# Function Name: handle_mouse_click
# Description:
# 	Check for the right mouse button and call create_menu_instance function
func handle_menu_mouse_hover() -> void:
	if monkey_action_state == MonkeyState.M_STATES.IDLE:
		if is_monkey_selected:
			if Input.is_action_just_pressed("MonkeyActionMenu"):
				is_create_menu = !is_create_menu
				# Menu Toggle
				if is_create_menu:
					create_menu_instance()
				else:
					destory_menu_instance()
					is_create_menu = false



# Function Name: create_menu_instance
# Description:
# 	Create a new instance of the monkey_gui_scene that contains the action buttons
func create_menu_instance() -> void:
	monkey_action_buttons = monkey_gui_scene.instantiate()
	monkey_action_buttons.position = Vector2(0, -128) 
	monkey_action_buttons.action_button_activated.connect(_on_action_button_activated)
	self.add_child(monkey_action_buttons)



# Function Name: destory_menu_instance
# Description:
# 	If the scene is valid then remove the child from the Monkey tree
func destory_menu_instance() -> void:
	if monkey_action_buttons:
		monkey_action_buttons.collapse_buttons()
		


	

"""	=======		TEMP TEST FUNCTION		======="""

func test_panic_bar():
	if Input.is_action_just_pressed("ui_left"):
		if $StateController:
			$StateController.panic_state.current_panic_percentage += 0.1
			$MonkeyBarIndicators/MonkeyPanicBarIndicator.add_panic_to_bar()
			print_debug("Panic State %: ", $StateController.panic_state.current_panic_percentage)
	if Input.is_action_just_pressed("ui_right"):
		if $StateController:
			$StateController.panic_state.current_panic_percentage -= 0.1
			$MonkeyBarIndicators/MonkeyPanicBarIndicator.sub_panic_from_bar()
			print_debug("Panic State %: ", $StateController.panic_state.current_panic_percentage)


"""	=======		END TEMP TEST FUNCTION	======="""


