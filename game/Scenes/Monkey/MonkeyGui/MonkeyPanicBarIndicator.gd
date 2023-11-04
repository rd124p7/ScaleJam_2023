extends Node2D

# Min-Max size along the x-axis
const min_line_size: int = -25
const max_line_size: int = 25


# Number of points, clamp to make sure it stays inbetween the correct range
# To prevent index out of range errors
var current_number_of_points: int = 1:
	set(value):
		current_number_of_points = clamp(value, 1, 11)
	get:
		return current_number_of_points


# Current Panic Level
var current_panic_line_amount: int = -25
var line_increase_amount: int = 5


# Function Name: _on_bar_shake_timer_timeout
# Description:
#	When the timer times out then call animate_bar_shake
func _on_bar_shake_timer_timeout():
	animate_bar_shake() 



# Function Name: add_panic_to_bar
# Description:
#	Add a point to the line every 5 pixels, if it is under 50px, increase the current_number_of_points
# 	then call the animate_color function to animate the line color
func add_panic_to_bar() -> void:
	if current_panic_line_amount < max_line_size:
		current_panic_line_amount += line_increase_amount
		$MainLine.add_point(Vector2(current_panic_line_amount, 0))
		current_number_of_points += 1
		animate_color()



# Function Name: sub_panic_from_bar
# Description:
#	Remove the point using current_number_of_points value, then call the animate_color 
#	function to animate the line color
func sub_panic_from_bar() -> void:
	if current_panic_line_amount > min_line_size:
		current_panic_line_amount -= line_increase_amount
		current_number_of_points -= 1
		$MainLine.remove_point(current_number_of_points)
		animate_color()



# Function Name: animate_color
# Description:
# 	Create a tween to change the color of the self_modulate property, 
#	when the current_number_of_points is 8 or greater then the shake timer will start 
func animate_color() -> void:
	var color_tween = create_tween().bind_node(self).set_trans(Tween.TRANS_CIRC)

	if current_number_of_points > 4 && current_number_of_points < 8:
		color_tween.tween_property($MainLine, "self_modulate", Color(0.95, 0.95, 0.0), 0.5)
		stop_timer_if_started()
	elif current_number_of_points >= 8:
		color_tween.tween_property($MainLine, "self_modulate", Color(0.95, 0.0, 0.0), 0.5)
		$BarShakeTimer.start()
	else:
		color_tween.tween_property($MainLine, "self_modulate", Color(1.0, 1.0, 1.0), 0.5)
		stop_timer_if_started()



# Function Name: animate_bar_shake
# Description:
#
func animate_bar_shake() -> void:
	var bar_shake_tween = create_tween().bind_node(self).set_trans(Tween.TRANS_BOUNCE)
	bar_shake_tween.tween_property(self, "rotation", -0.15, 0.1)
	bar_shake_tween.chain().tween_property(self, "rotation", 0.15, 0.1)
	bar_shake_tween.chain().tween_property(self, "rotation", 0, 0.1)


# Function Name: stop_timer_if_started
# Description:
# 	If the timer is not stopped then stop the timer
func stop_timer_if_started() -> void:
	if !$BarShakeTimer.is_stopped():
		$BarShakeTimer.stop()
