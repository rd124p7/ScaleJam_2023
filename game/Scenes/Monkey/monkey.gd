extends CharacterBody2D


# Load Scenes
var monkey_gui_scene: PackedScene = preload("res://Scenes/Monkey/MonkeyGui/monkey_gui.tscn")


# Monkey States
var monkey_action_state: MonkeyState


# Monkey Gui Variables
var monkey_action_buttons: Variant
var is_monkey_selected: bool = false
var is_create_menu: bool = false


func _ready():

	print_debug(self.position)

func _process(_delta):
	handle_menu_mouse_click()


func _on_mouse_entered():
	is_monkey_selected = true
	
func _on_mouse_exited():
	is_monkey_selected = false
	

# Function Name: handle_mouse_click
# Description:
# 	Check for the right mouse button and call create_menu_instance function
func handle_menu_mouse_click() -> void:
	if is_monkey_selected:
		if Input.is_action_just_pressed("MonkeyActionMenu"):
			is_create_menu = !is_create_menu
			Node.print_orphan_nodes()
			# Menu Toggle
			if is_create_menu:
				create_menu_instance()
			else:
				destory_menu_instance()



# Function Name: create_menu_instance
# Description:
# 	Create a new instance of the monkey_gui_scene that contains the action buttons
func create_menu_instance() -> void:
	if is_create_menu:
		monkey_action_buttons = monkey_gui_scene.instantiate()
		monkey_action_buttons.position = Vector2(0, -128) 
		print_debug("Monkey button ", monkey_action_buttons.position)
		
		if monkey_action_buttons:
			self.add_child(monkey_action_buttons)



# Function Name: destory_menu_instance
# Description:
# 	If the scene is valid then remove the child from the Monkey tree
func destory_menu_instance() -> void:
	if is_instance_valid(monkey_action_buttons) && monkey_action_buttons:
		self.remove_child(monkey_action_buttons)



