extends Control


signal action_button_activated


# Function Name: _ready
# Description:
# 	Set all of the buttons scale to 0, set control scale to 0.8 as default
func _ready():
	self.scale = Vector2(0.8, 0.8)
	for button_node in self.get_children():
		button_node.scale = Vector2(0, 0)



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
# 	When the node is removed from the tree, free the object from memory
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


# Function Name: scale_up
# Description:
# 	Scale the parent control node up to 1.8
func scale_up() -> void:
	var scale_up_tween = create_tween().set_trans(Tween.TRANS_EXPO)
	scale_up_tween.tween_property(self, "scale", Vector2(1.8, 1.8), 1)



# Function Name: scale_down
# Description:
#	Scale the parent control node down to 0.8
func scale_down() -> void:
	var scale_up_tween = create_tween().set_trans(Tween.TRANS_EXPO)
	scale_up_tween.tween_property(self, "scale", Vector2(0.8, 0.8), 1)