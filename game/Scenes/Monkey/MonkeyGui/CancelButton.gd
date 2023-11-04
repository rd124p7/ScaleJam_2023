extends Control

signal cancel_button_activated






func _on_cancel_button_texture_mouse_exited():
	pass # Replace with function body.

func _on_cancel_button_texture_mouse_entered():
	pass # Replace with function body.

func _on_cancel_button_texture_pressed():
	cancel_button_activated.emit()
	