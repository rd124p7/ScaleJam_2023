extends Control


signal action_button_activated


# Function Name: _ready
# Description:
# 	Set all of the buttons scale to 0, set control scale to 0.8 as default
func _ready():
	self.scale = Vector2(0.8, 0.8)
	for button_node in self.get_children():
		button_node.scale = Vector2(0, 0)

	print(get_parent())



# Function Name: _on_action_button_pressed
# Description:
# 	Emit action_button_activated when the action button is pressed
func _on_action_button_pressed():
	action_button_activated.emit()



# Function Name: _on_tree_entered
# Description:
#	When the object is created start to animate the buttons
func _on_tree_entered():
	animate_buttons()

# Function Name: _on_tree_exited
# Description:
#	Remove menu node from memory
func _on_tree_exited():
	self.queue_free()



# Function Name: animate_buttons
# Description:
#	Animates the buttons, the buttons will grow then shrink one by one
func animate_buttons() -> void:
	if self:
		var button_tween = get_tree().create_tween().bind_node(self).set_trans(Tween.TRANS_BOUNCE)

		# Action Button Animation
		button_tween.tween_property($ActionButton, "scale", Vector2(1.4, 1.4), 0.2)
		button_tween.chain().tween_property($ActionButton, "scale", Vector2(1.0, 1.0), 0.1)

		# Bladder Button Animation
		button_tween.chain().tween_property($BladderButton, "scale", Vector2(1.4, 1.4), 0.2)
		button_tween.chain().tween_property($BladderButton, "scale", Vector2(1.0, 1.0), 0.1)
		
		# Feed Button Animation
		button_tween.chain().tween_property($FeedButton, "scale", Vector2(1.4, 1.4), 0.2)
		button_tween.chain().tween_property($FeedButton, "scale", Vector2(1.0, 1.0), 0.1)

		# Cancel Button Animation
		button_tween.chain().tween_property($CancelButton, "scale", Vector2(1.4, 1.4), 0.2)
		button_tween.chain().tween_property($CancelButton, "scale", Vector2(1.0, 1.0), 0.1)



func collapse_buttons() -> void:
	var button_tween = get_tree().create_tween().bind_node(self).set_trans(Tween.TRANS_BOUNCE)
	button_tween.tween_property($CancelButton, "scale", Vector2(0, 0), 0.2)
	button_tween.chain().tween_property($FeedButton, "scale", Vector2(0, 0), 0.2)
	button_tween.chain().tween_property($BladderButton, "scale", Vector2(0, 0), 0.2)
	button_tween.chain().tween_property($ActionButton, "scale", Vector2(0, 0), 0.2)
	button_tween.tween_callback(self.remove_menu_from_tree)


# Function Name: remove_menu_from_tree
# Description:
# 	Remove this node from it's parent tree
func remove_menu_from_tree() -> void:
	get_parent().remove_child(self)

