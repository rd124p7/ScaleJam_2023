extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_player_camera_controller_highlight_possible_actions():
	print("Scale")
	var highlight_tween = create_tween().set_trans(Tween.TRANS_ELASTIC)
	highlight_tween.tween_property($Sprite2D, "scale", Vector2(2.0, 2.0), 0.4)



func _on_machine_type_machine_broken():
	print("Machine is Broken")